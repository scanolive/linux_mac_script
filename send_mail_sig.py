#!/usr/bin/env python
#encoding=utf-8

#################################################
#
#   File Name: send_mail_sig.py
#   Author: scan
#   Created Time: 2019-07-22 13:37:01
# 
#################################################

import sys
if sys.version_info.major == 2:
    reload(sys)
    sys.setdefaultencoding('utf-8')
    from email.mime.multipart import MIMEMultipart
    from email.mime.multipart import MIMEBase
    from email.mime.text import MIMEText
    from email.mime.application import MIMEApplication
    from email import Encoders as encoders
    from email import Utils as utils
else:
    from email.mime.multipart import MIMEMultipart
    from email.mime.multipart import MIMEBase
    from email.mime.text import MIMEText
    from email.mime.application import MIMEApplication
    from email import  encoders
    from email import utils as utils
import os
import re
import time
import smtplib
import base64

SMTPserver = 'smtp.163.com'
FROM = 'yourmail@163.com'
PORT = 25
USER = 'username'
PASS = 'password'
SIG_FILE = '/Users/rill/Documents/other/signature.html'

def Send_Mail(address,subject,content,file_list_str):
	to = ','.join(address)
	file_list = file_list_str.split(',')
	main_msg = MIMEMultipart()
	contype = 'application/octet-stream'  
	maintype, subtype = contype.split('/', 1)

	text_msg = MIMEText(content,'html',_charset="utf-8")  
	main_msg.attach(text_msg)
	for file_name in file_list:
		data = open(file_name, 'rb')  
		file_msg = email.MIMEBase.MIMEBase(maintype, subtype)  
		file_msg.set_payload(data.read())  
		data.close( )  
		email.Encoders.encode_base64(file_msg)
		basename = os.path.basename(file_name)  
		file_msg.add_header('Content-Disposition', 'attachment', filename= '=?utf-8?b?' + base64.b64encode(basename.encode('UTF-8')) + '?=')
		main_msg.attach(file_msg)  

	if os.path.isfile(SIG_FILE):
		sig_file_f = open(SIG_FILE, 'rb') 
		sig_str = sig_file_f.read()
		sig_msg = MIMEText(sig_str,'html','utf-8')
		main_msg.attach(sig_msg)
	
	main_msg['to'] = to
	main_msg['from'] = FROM
	main_msg['subject'] = subject	
	if file_name != '':
		main_msg['Date'] = email.Utils.formatdate( )  
	fullText = main_msg.as_string( )
	
	send_num = 0
	while send_num < 2:
		smtp_server = smtplib.SMTP(SMTPserver,str(PORT))
		try:
			smtp_server.login(USER,PASS)
			smtp_server.sendmail(FROM, address, fullText)
			send_num = 100
		except smtplib.SMTPException as e:
			send_num = send_num + 1
			print(str(e))
			time.sleep(5)
		finally:
			smtp_server.quit()
if len(sys.argv) == 5:
	address = sys.argv[1]
	subject = sys.argv[2]
	content = sys.argv[3]
	address = address.split(',')
	file_name = sys.argv[4]
	Send_Mail(address,subject,content,file_name)
elif len(sys.argv) == 4:
	address = sys.argv[1]
	subject = sys.argv[2]
	content = sys.argv[3]
	address = address.split(',')
	file_name = ''
	Send_Mail(address,subject,content,file_name)
else:
	print("Usage:"+sys.argv[0]+" address subject content att_filename")
