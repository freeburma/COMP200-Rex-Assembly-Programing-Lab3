.text 
.global main

main : 
      addi $1, $0, 'X'
      
      # This will loop until the TDS bits is enable 
loop :       
      # Getting the status of the Serial 1
      lw    $2, 0x70003 ($0)      
      
      # Check the Transmit Data Sent (TDS) bit is enable 
      andi  $2, $2, 0x2             # TDS bit is at the second place on the Serial Status Regitser - 0x2 = Oxb0010 in base 2
      
      beqz $2, loop
      
      # Get teh data 
      sw    $1, 0x71000 ($0)
      
      jr $ra
      
      
