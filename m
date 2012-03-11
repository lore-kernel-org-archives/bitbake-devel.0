Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S6iZq-0005fA-9Q for bitbake-devel@lists.openembedded.org;
	Sun, 11 Mar 2012 14:12:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2BD42pI002408;
	Sun, 11 Mar 2012 13:04:02 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30343-10; Sun, 11 Mar 2012 13:03:57 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2BD3m5i002402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Mar 2012 13:03:53 GMT
Message-ID: <1331471028.14263.10.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 11 Mar 2012 13:03:48 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "Garman, Scott A" <scott.a.garman@intel.com>
Subject: Codeparser cache braindump
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 11 Mar 2012 13:12:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I've spent quite a bit of time experimenting with the codeparser cache
recently. There are several challenges since this appears to be one area
we're suffering badly with performance, memory usage and data lifetime
issues.

To give some context for people not familiar with it, we now parse
various python and shell code fragments in order to calculate dependency
information about them. Rather than do this all the time, we have a
cache of results. When we need to find the dependencies of a new
fragment of code, we take the checksum of the code and compare it with
our cache. If we have matching entries, we can skip to the end result.

There are two levels to the speedup. By having a lookup cache in memory,
we gain some speed. By saving the cache to disk and reloading there are
further speed gains. I made some parsing time measurements:

Totally clean cache directory (i.e. generating cache):
real	0m50.083s
user	2m18.273s
sys	0m8.317s

Totally clean cache directory (but no merge and save to disk of the
cache):
real	0m38.302s
user	2m20.173s
sys	0m4.828s

Parsing all recipes with a valid cache file:
real	0m23.309s
user	1m15.333s
sys	0m5.100s

So there is a 12s overhead to writing out the cache but this saves 15s
on subsequent parsing runs. The cache is usually valid so we get the
speedup pretty much all of the time apart from a clean tmpdir.

I also looked at how much the shell cache verses the python cache is
worth:

Shell only Cache
real	0m31.231s
user	1m46.027s
sys	0m4.656s

Python only cache
real	0m34.474s
user	1m54.979s
sys	0m6.900s

so they are both fairly useful. I looked at the usage of the data within
the caches and in general we have 90-95% of single use of a given code
fragment. The python cache has around 11000 entries, the shell cache
8500 and the pickled on disk cache file is around 4.4MB.

There are also some complications. The multithreaded parsing means we
end up with a cache in several different contexts and have to merge
these together. Finding a safe and efficient algorithm to do this is
tricky. There are some issues in the current code in this area and Yocto
has a "Ctrl+C causes bitbake to hang" issue filed which looks to be
related to this in some use cases.

At this point I noticed the on disk cache file contained a lot of
duplication of strings and I started looking into what python was doing
with these. There are some good details at:

http://stackoverflow.com/questions/2123925/when-does-python-allocate-new-memory-for-identical-strings

The short summary is that I believe our original memory structures as
parsed are pretty good but as soon as we pickle the data and write it to
disk, duplicates are created. Certainly once we unpickle the data, we
have every string duplicated. This goes a long way to explaining why
bitbake appears to use a lot more memory on second runs compared with
original parsing.

The good news is there are some games we can play with intern() to
significantly address the duplication. With some code I'm experimenting
with, the 4.4MB on disk file is reduced to about 2.0MB.

The final issue I'm worrying about is data lifetime. Currently these
caches just grown indefinitely until you wipe the files out. The files
tend to grow large, particularly in multiple machine setups.

At this point I've not come up with a good way of deciding when to
remove a cache entry. Options are:

a) Have a timestamp and remove "old" entries. The trouble is old can
still be valid and used.
b) Have a counter which increments upon usage. The trouble is a partial
parse doesn't touch some entries which would still be useful upon a full
parse. It also doesn't deal well with multiple and maybe infrequently
used machines.

At this point I think the best way forward is going to be to integrate
the improvements I mention above. We can then see if the files are still
causing excessive memory usage or whether things become more tolerable
with the efficiency improvements. It doesn't solve the life cycle
problem and I'd love to hear ideas on that.

I'll propose some patches once I get home and the jetlag has worn off.

Cheers,

Richard





