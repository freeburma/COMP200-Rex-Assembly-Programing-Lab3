.text
.global main
main: 
	
receive:
	# Get the  serial port 2 status 
	lw 	$3, 0x71003($0)

	# check if the RDR (Receive Data Register) bit is set 
	andi 	$3, $3, 0x1
	beqz 	$3, receive             # Keep Looping unitil it receive the data

     
	
convert_toUpperCase: 	
       # Getting the chars in serial 2
	lw 	$4, 0x71001($0)
	sgeui $5, $4, 97        # 'a'
	beqz 	$5, send

	sleui $5, $4, 122             # 'z'
	beqz 	$5, send

	subui $4, $4, 32              # Getting the Captial -A to Z 
	                              # a - start form 97 
	                              # A - start from 65
	                              # --------------------
	                              #                32
	
	

send: 
	

	# Get the first serial port status 
	lw 	$2, 0x70003($0)

	# check if the TDS - (Transmit Data Register) bit is set 
	andi 	$2, $2, 0x2
	
	# if not, loop and try again
	beqz 	$2, send

	
display: 
	# serial port is now ready so transmit character 
	sw 	$4, 0x70000($0)	
	
	j receive



	 
	
	

