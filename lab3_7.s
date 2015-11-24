.text
.global main
main: 
	
receiveRDR:
	# Get the  serial port 1 status 
	lw 	$3, 0x70003($0)

	# Check if the RDR (Receive Data Register) bit is set 
	andi 	$3, $3, 0x1
	beqz 	$3, receiveRDR2             # Keep Looping unitil it receive the data

        # Receiving the value in Serial 1
        lw $4, 0x70001 ($0)                 
        jal lowerCase   

transmitTDR2: 
        # Get the  serial port 2 status 
        lw      $3, 0x71003 ($0)
        andi    $3, $3, 0x2             # Checking the Transmit Data Register Bit is set
        beqz    $3, transmitTDR2

 
        sw $4, 0x71000 ($0)             # Displaying the value in Serial 2
        j receiveRDR	

	
receiveRDR2:
	# Get the  serial port 2 status 
	lw 	$3, 0x71003($0)

	# Checking  the RDR (Receive Data Register) bit is set 
	andi 	$3, $3, 0x1
	beqz 	$3, receiveRDR             # Keep Looping unitil it receive the data	
	
	# Receiving the value in Serial 2
        lw $4, 0x71001 ($0)                
        jal convertUpperCase    
        
transmitTDR: 
        # Receiving the value in Serial 1
        lw      $3, 0x70003 ($0)
        andi    $3, $3, 0x2                 # Checking the Transmit Data Register Bit is set
        beqz    $3, transmitTDR         	
	

        sw $4, 0x70000 ($0)                 # Displaying the value in Serial 2
        j receiveRDR2		


lowerCase: 
        add $5, $5, $0
        add $6, $6, $0
        sgeui $5, $4, 65             # 'A'
       	sleui $6, $4, 90             # 'Z'
	
	and $7, $5, $6
	bnez $7, lower

	                        	    
convertUpperCase: 	
       # Getting the chars in serial 2
	add $5, $5, $0
	add $6, $6, $0
	sgeui $5, $4, 97              # 'a'
	sleui $6, $4, 122             # 'z'
	and $7, $5, $6
	bnez $7, upper


        jr $ra	
        	
upper: 
	subui $4, $4, 32              # Getting the Captial -A to Z 
	                              # a - start form 97 
	                              # A - start from 65
	                              # --------------------
	                              #                32	
       jr $ra
      

lower:
	addui $4, $4, 32 
	jr $ra
	
	





	 
	
	

