Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UHwtN-0000kS-Qv for bitbake-devel@lists.openembedded.org;
	Tue, 19 Mar 2013 14:48:08 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2JDeD2e007191; Tue, 19 Mar 2013 13:40:13 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id tOsEdDfocqRM; Tue, 19 Mar 2013 13:40:13 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2JDe9uH007181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Tue, 19 Mar 2013 13:40:11 GMT
Message-ID: <1363699850.16482.102.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@windriver.com>
Date: Tue, 19 Mar 2013 13:30:50 +0000
In-Reply-To: <51485D95.7010301@windriver.com>
References: <51476713.8050506@windriver.com> <1363692919.16482.95.camel@ted>
	<51485D95.7010301@windriver.com>
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
X-List-Received-Date: Tue, 19 Mar 2013 13:48:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2013-03-19 at 07:44 -0500, Mark Hatle wrote:
> On 3/19/13 6:35 AM, Richard Purdie wrote:
> > On Mon, 2013-03-18 at 14:12 -0500, Mark Hatle wrote:
> >> I found a strange situation today and I'm looking for an explanation to see if
> >> it's a bug or not.
> >>
> >> Between a .bb and .bbappend file, I end up with a situation where
> >> "reproducer.bb" and "reproducer.bbappend" get the following:
> >>
> >> RDEPENDS_${PN} += "hello1"
> >> RDEPENDS_reproducer += "hello2"
> >>
> >> When evaluatated (bitbake -e reproducer) I get:
> >>
> >> #
> >> # $RDEPENDS_reproducer [2 operations]
> >> #   append
> >> /home/mhatle/git/oss/oe-core/local/recipes-sample/hello/reproducer_1.0.bb:16
> >> #     "hello2"
> >> #   rename from RDEPENDS_${PN} data.py:161 [expandKeys]
> >> #     " hello1"
> >> # computed:
> >> #   " hello1"
> >> RDEPENDS_reproducer="hello1"
> >>
> >> So that tells me that it was initially set to "hello2", and then the ${PN}
> >> expansion occurred, causing it to be set to "hello1".
> >>
> >> So my first question is, should this be "hello1", "hello2", "hello1 hello2" or
> >> "hello2 hello1"?
> >
> > expandKeys tramples existing values so that result doesn't surprise me
> > even if its not what you expect.
> >
> >> The second issue is a bit stranger.. if I change the build from "reproducer" to
> >> "lib32-reproducer", I get a different result:
> >>
> >> # $RDEPENDS_lib32-reproducer [3 operations]
> >> #   rename from RDEPENDS_${PN} data.py:161 [expandKeys]
> >> #     " hello1"
> >> #   rename from RDEPENDS_reproducer classextend.py:95 [rename_package_variables]
> >> #     " hello2"
> >> #   set classextend.py:71 [map_depends_variable]
> >> #     "lib32-hello2"
> >> # computed:
> >> #   "lib32-hello2"
> >> RDEPENDS_lib32-reproducer="lib32-hello2"
> >>
> >> This time the system pulled in the ${PN} version first (obviously expanded it),
> >> and then turned out and found the RDEPENDS_reproducer, and remapped it to
> >> RDEPENDS_lib32-reproducer replacing the origin ${PN} version.
> >>
> >> So I have two concerns, the first is the value is 'different' from the
> >> non-multilib version, and second, what should the expected output be for this item?
> >
> > Again, I'm not surprised. The multilib remapping code gets executed at
> > the end, after expandKeys and in this case last wins. So I can see why
> > the system is doing it, even if you don't like the end result.
> >
> > Setting multiple conflicting keys like this is dangerous :(
> >
> > We've tried to fix this before and ended up just digging deeper holes
> > with more problems.
> 
> Is there any way we can issue a warning from the parser or something when it 
> finds conflicting keys?  My concern isn't that conflicting keys are causing a 
> problem -- but more that someone may not realize this is a problem, and they are 
> getting incorrect results.
> 
> I know since posting this query, I've had a few people comment to me that they 
> saw the same problem and it took them a very long time to diagnose it and figure 
> out it "just didn't work".

We could probably have data.expandKeys() check for existing values and
then error if its overwriting something else. I have no idea how often
the metadata does that for "correct" reasons...

Cheers,

Richard





