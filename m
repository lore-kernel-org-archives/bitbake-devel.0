Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UHv5f-0005BP-6c for bitbake-devel@lists.openembedded.org;
	Tue, 19 Mar 2013 12:52:49 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2JBfqaU028761; Tue, 19 Mar 2013 11:44:46 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Oo4qNSo6H5oz; Tue, 19 Mar 2013 11:44:45 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2JBib1D028992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Tue, 19 Mar 2013 11:44:40 GMT
Message-ID: <1363692919.16482.95.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Tue, 19 Mar 2013 11:35:19 +0000
In-Reply-To: <51476713.8050506@windriver.com>
References: <51476713.8050506@windriver.com>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bitbake / oe-core anomaly with multilibs
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
X-List-Received-Date: Tue, 19 Mar 2013 11:52:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-03-18 at 14:12 -0500, Mark Hatle wrote:
> I found a strange situation today and I'm looking for an explanation to see if 
> it's a bug or not.
> 
> Between a .bb and .bbappend file, I end up with a situation where 
> "reproducer.bb" and "reproducer.bbappend" get the following:
> 
> RDEPENDS_${PN} += "hello1"
> RDEPENDS_reproducer += "hello2"
> 
> When evaluatated (bitbake -e reproducer) I get:
> 
> #
> # $RDEPENDS_reproducer [2 operations]
> #   append 
> /home/mhatle/git/oss/oe-core/local/recipes-sample/hello/reproducer_1.0.bb:16
> #     "hello2"
> #   rename from RDEPENDS_${PN} data.py:161 [expandKeys]
> #     " hello1"
> # computed:
> #   " hello1"
> RDEPENDS_reproducer="hello1"
> 
> So that tells me that it was initially set to "hello2", and then the ${PN} 
> expansion occurred, causing it to be set to "hello1".
> 
> So my first question is, should this be "hello1", "hello2", "hello1 hello2" or 
> "hello2 hello1"?

expandKeys tramples existing values so that result doesn't surprise me
even if its not what you expect.

> The second issue is a bit stranger.. if I change the build from "reproducer" to 
> "lib32-reproducer", I get a different result:
> 
> # $RDEPENDS_lib32-reproducer [3 operations]
> #   rename from RDEPENDS_${PN} data.py:161 [expandKeys]
> #     " hello1"
> #   rename from RDEPENDS_reproducer classextend.py:95 [rename_package_variables]
> #     " hello2"
> #   set classextend.py:71 [map_depends_variable]
> #     "lib32-hello2"
> # computed:
> #   "lib32-hello2"
> RDEPENDS_lib32-reproducer="lib32-hello2"
> 
> This time the system pulled in the ${PN} version first (obviously expanded it), 
> and then turned out and found the RDEPENDS_reproducer, and remapped it to 
> RDEPENDS_lib32-reproducer replacing the origin ${PN} version.
> 
> So I have two concerns, the first is the value is 'different' from the 
> non-multilib version, and second, what should the expected output be for this item?

Again, I'm not surprised. The multilib remapping code gets executed at
the end, after expandKeys and in this case last wins. So I can see why
the system is doing it, even if you don't like the end result.

Setting multiple conflicting keys like this is dangerous :(

We've tried to fix this before and ended up just digging deeper holes
with more problems.

Cheers,

Richard



