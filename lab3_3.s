.text 
.global main

main : 
      addi $1, $0, 'X'
      addi $3, $0, 25
      

      
      # This will loop until the TDS bits is enable 
loop :      
     
      # Get teh data 
      sw    $1, 0x70000 ($0)
      
      # decrement by 1
      subui $3, $3, 1       
      bnez $3, loop
      jr $ra
      
      
