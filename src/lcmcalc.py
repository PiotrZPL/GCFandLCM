def calclcm(numberlist):
	try:
		nums = numberlist.split(".")
		finallcm = 0
		for iii in range(len(nums)):
			nnn = nums[iii]
			nnn = int(nnn.strip())
			if iii == 0:
				finallcm = nnn
			else:
				finallcm = lcm(finallcm, nnn)
		return True, finallcm
	except:
		return False, 0

def lcm(aaa, bbb):
	greater = max(aaa, bbb)
	while True:  
		if((greater % aaa == 0) and (greater % bbb == 0)):  
			lcm = greater  
			break  
		greater += 1  
	return lcm      
