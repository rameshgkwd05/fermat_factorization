#################################################
# Program Name: Factorization of RSA numbers n = pq by Fermat’s method.
# Authors: Ramesh, Tarun, Ashish, Naman, Swapnil Bari, Onkar, Swapnil Gusani,
#               Mayur, Sagar, Vishal
# Date: Wed,April 15, 2015
# Usage: init(<length>)
#             init5()
#		init1()
#################################################

# START_OF_CODE

# get_random_prime(In,prev_prime) 
# arguments: ln = length (number of digits)
#                    prev_prime = previously generated prime number 
#This function generates a random prime number of specified length(ln) which
# should be different than previously generated prime number(prev_prime)
def get_random_prime(ln,prev_prime):
	while true:	
		p = random_prime(10^ln)
		if ((p != prev_prime) & (len(p.str()) == ln)):
			return p


# D is the dictionary to record the mapping {prime_factor:#occurrances}
# The keys of dictionary(D) are prime divisors of given number	
D = {}

# fermat_call(n)
# argument: n = taget number , whose prime divisors will be calculated
# This function takes a number as input and call fermat_helper(n) to get 
# prime divisors of n in dictionary D
# It prints the prime factors of n
# e.g. Prime factors of 84
# 2
# 3
# 7
# It generates and symbolic expression representing prime factorisation of n
#  e.g. 84 = 2^2 x 3^1 x 7 
def fermat_call(n):
	fermat_helper(n)
	for el in D.keys():
		print el
	st= "Prime Factorization of  "+n.str()+" = "
	for el in D.keys():
		st+=el.str()+"^"+(D.get(el)).str()+" x "
	
	print st[:-2]
	D.clear()
	
	
# fermat_factor(n)
#  argument: n = taget number , whose prime divisors will be calculated
# This function implements basic fermat theorem for finding prime factors of
# given number
def fermat_factor(n):
	if is_even(n):
		n2 = n/2
		return n2,2
	
	if is_prime(n):
		return 1,n
	
	a = ceil(sqrt(n))
	b2 = a*a - n
	
	while(is_square(b2) == False):
		a +=1
		b2 = a*a - n

	b = floor(sqrt(b2))

	return (a-b),(a+b)

# fermat_helper(n)
#  argument: n = taget number , whose prime divisors will be calculated
# This function is a recursive function.
# Initially it calls the fermat_factor(n) and if the obtained factors are not prime  
# then it recursively calls itself with obtained factors as input
# Each time a prime factor is obtained, it adds it into dictionary D
# Eventually we get a dictionary mapping of all prime factors of  given number
# and number of times that factor appears in the prime factorization of n
def fermat_helper(n):
	sa,sb = fermat_factor(n)
	a = Integer(sa)
	b = Integer(sb)
	
	if a != 1:
		fermat_helper(a)
		fermat_helper(b)

	else:
		if D.has_key(b):               # If factor is already computed
			D[b] = D.get(b) + 1 # then increment ite power
		else:                               # If factor is appeared for first time
			D[b] = 1                 # then add new entry in dictionary D
			

#################################################

# init5()
# arguments: none
# This function  genrates 5 random prime pairs (p,q)of 5-digit length.
# calculates n = p*q (RSA)
# calculates prime factors of (p-1), (q-1) and n
# It prints the cpu seconds invested in prime factor calculation and IO
def init5():
	for i in range(5):
		t= cputime()

		p = get_random_prime(5,1)
		q = get_random_prime(5,p)
		n = p*q
		print "Sample Case : ",i+1
		print "\np = ",p," , q = ",q," , n = ",n 
		print "\nPrime Factors of  p-1 where p = ",p,":"
		
		fermat_call(p-1)
		print "\nPrime Factors of  q-1 where q = ",q,":"
		fermat_call(q-1)
		print "\nPrime Factors of  n where n = ",n,":"
		fermat_call(n)
		print "cpu seconds = ",cputime(t)
                
		print "***************************************************************"
		
# init(L)
# arguments: L=specified number of digits in random prime 
# This function  genrates  random prime pairs (p,q)of given-digit length(L).
# calculates n = p*q (RSA)
# calculates prime factors of (p-1), (q-1) and n
# It prints the cpu seconds invested in prime factor calculation and IO
def init(L):
	
	print "Test case for ",L," digit prime factors"
	t= cputime()

	p = get_random_prime(L,1)
	q = get_random_prime(L,p)
	n = p*q
	print "\np = ",p," , q = ",q," , n = ",n 
	print "\nPrime Factors of  p-1 where p = ",p,":"
	fermat_call(p-1)
	print "\nPrime Factors of  q-1 where q = ",q,":"
	fermat_call(q-1)
	print "\nPrime Factors of  n where n = ",n,":"
	fermat_call(n)

	print "cpu seconds = ",cputime(t)
	print "********************************************************************"

# init1()
# arguments:  none
# This function  genrates  random prime pairs (p,q)of digit length 1 to 10.
# For each prime pair it calculates n = p*q (RSA)
# calculates prime factors of (p-1), (q-1) and n
# It prints the cpu seconds invested in prime factor calculation and IO
def init1():
	print "Test case for 1 - 10 digit prime numbers"

	for i in range(10):
		print "\nSample case ",i+1,"-digit:"
		t= cputime()

		p = get_random_prime(i+1,1)
		q = get_random_prime(i+1,p)
		n = p*q
		print "\np = ",p," , q = ",q," , n = ",n 
		print "\nPrime Factors of  p-1 where p = ",p,":"
		fermat_call(p-1)
		print "\nPrime Factors of  q-1 where q = ",q,":"
		fermat_call(q-1)
		print "\nPrime Factors of  n where n = ",n,":"
		fermat_call(n)

		print "cpu seconds = ",cputime(t)
		print "***************************************************************"
#################################################
# Comparison of fermat Theorem with naive method of factorization

# myfactor(N)
# arguments: N= target number whose prime factors will be calculated
# This function calculates prime factors of given number within range(2,N+1)
def myfactor(N):
	if N <= 0:
		return [N]
	for x in primes(2,N+1):
		if N==1:
			break
		if N%x==0:
			print x
			while N%x==0:
				N = N/x
# myfactor_helper(pq,n)
# arguments: p,q,n RSA numbers
# This function calls the naive factorization function which employs brute-force
# approach and prints cpu-time invested
def myfactor_helper(p,q,n):
	t= cputime()
	print "\nPrime Factors of  p-1 where p = ",p,":"
	myfactor(p-1)
	print "\nPrime Factors of  q-1 where q = ",q,":"
	myfactor(q-1)
	print "\nPrime Factors of  n where n = ",n,":"
	myfactor(n)
	print "cpu seconds = ",cputime(t)
				N = N/x
# fermat_helper_pqn(p,q,n):
# arguments: p,q,n RSA numbers
# This function calls the fermat factorization function fermat_call(n) 
# It then prints cpu-time invested
def fermat_helper_pqn(p,q,n):
	t= cputime()
	print "\nPrime Factors of  p-1 where p = ",p,":"
	fermat_call(p-1)
	print "\nPrime Factors of  q-1 where q = ",q,":"
	fermat_call(q-1)
	print "\nPrime Factors of  n where n = ",n,":"
	fermat_call(n)
	print "cpu seconds = ",cputime(t)

# comparison():
# This function compares the performance of feramat method with naive
# method
def comparison():
	for i in range(10):
		print "\nSample case ",i+1,"-digit:"
		t= cputime()

		p = get_random_prime(i+1,1)
		q = get_random_prime(i+1,p)
		n = p*q

		print "\np = ",p," , q = ",q," , n = ",n 
		print "*******************************************************"
		print "Factorization using Naive method:"
		myfactor_helper(p,q,n)

		print "********************************************************"
		print "Factorization using Fermat method:"
		fermat_helper_pqn(p,q,n)
		print "***************************************************************"
################################################
#END_OF_CODE
