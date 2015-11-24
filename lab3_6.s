
.text
.global main
main : 

serial_1_RDS : 
      # Get the  serial port 1 status 
      lw    $3, 0x70003 ($0)        
      
      # check if the RDR (Receive Data Register) bit is set 
      andi  $3, $3, 0x1               
      beqz  $3, serial_2_RDS              # Keep Looping unitil it receive the
      
serial_2_RDS : 
      lw    $3, 0x71003 ($0)        # load the serial port 1 status to $3
      andi  $3, $3, 0x1               # check if Receive Data Receiver (RDR) bit is set
      beqz  $3, serial_1_RDS     # if not set, then go check serial port 2    
            

      
serial_1_transmit : 
      lw    $2, 0x70003 ($0)         # load to $2 the serial port 2 status 
      andi  $2, $2, 0x2             # check if Transmit Data Sent (TDS) bit is set
      beqz  $2, serial_1_transmit
      
            
serial_2_transmit: 
      lw    $2, 0x71003 ($0)        # load to $2 the serial port 2 status 
      andi  $2, $2, 0x2             # check if Transmit Data Sent bit is set
      beqz  $2, serial_2_transmit    # if not check again
      
     
serial_1_receive : 
      lw    $4, 0x70001 ($0)        # load to $4 the data from serial port 1
      jal   checking_toUpperCase
            
serial_2_receive : 
      lw    $4, 0x71001 ($0)        # load the data from serial port 2 to $4
      jal   checking_toLowerCase
     
      

      
send : 
      sw    $4, 0x70000 ($0)        # if set then transmit
      j     serial_2_RDS      
      
      
checking_toUpperCase: 
      add   $6, $6, $0             
      add   $5, $5, $0              
      
      sgei  $6, $4, 0x41            # 'A'
      slei  $5, $4, 0x5a            # 'Z'
      
      and   $7, $5, $6             
      beqz  $7, checking_toLowerCase    
      addi  $4, $4, 0x20           
      
      j     return                  
      
checking_toLowerCase: 
     add   $6, $6, $0             
      add   $5, $5, $0                   
      
      sgei  $6, $4, 0x61            #'a'
      slei  $6, $4, 0x7a            # 'z'
      
      and   $7, $5, $6             
      beqz  $7, return             
      subi  $4, $4, 0x20            
      
      j return                      
      
return : 
      jr $ra      
