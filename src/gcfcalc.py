def calcgcf(numberlist):
	try:
		nums = numberlist.split(".")
		finalgcf = 0
		for iii in range(len(nums)):
			nnn = nums[iii]
			nnn = int(nnn.strip())
			if iii == 0:
				finalgcf = nnn
			else:
				finalgcf = gcf(finalgcf, nnn)
		return True, finalgcf
	except:
		return False, 0

def gcf(aaa, bbb):
	while bbb:
		aaa, bbb = bbb, aaa%bbb
	return aaa
