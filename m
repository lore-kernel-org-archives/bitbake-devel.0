Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1Tq2oO-0002K0-B1
	for bitbake-devel@lists.openembedded.org;
	Tue, 01 Jan 2013 15:27:24 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([174.115.5.73]:35521 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1Tq2Zs-0002Pi-OO for bitbake-devel@lists.openembedded.org;
	Tue, 01 Jan 2013 09:12:24 -0500
Date: Tue, 1 Jan 2013 09:12:20 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.DEB.2.02.1301010855180.18858@oneiric>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: still confused about _append and OVERRIDES and = and +=, argh
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
X-List-Received-Date: Tue, 01 Jan 2013 14:27:24 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  i'm trying to write a more comprehensive tutorial about what's
currently in the bitbake manual, section 2.2.1, "Override and append
ordering" and it's becoming clear that i still don't have a handle on
this.

  by way of intro, this is what got me wondering this morning so does
it make any sense?

meta/recipes-extended/chkconfig/chkconfig_1.3.58.bb:FILES_${PN}_append_linuxstdbase += "${libdir}/lsb"

note the combination of "_append_"? and "+=", which strikes me as
redundant, or so i thought until i played with this and now i'm more
confused than ever, so i ran some tests wherein i added this to my
local.conf:

OVERRIDES .= ":rday"

and started playing with chris larson's "bitbake-env" utility and
here's what i learned (for better or worse) based on adding different
sets of test settings underneath that in local.conf.

	test 1:

BLAH = "A"

$ bitbake-env BLAH
BLAH="A"
$

  totally predictable.  movin on ...

	test 2:

BLAH = "A"
BLAH_rday = "B"

$ bitbake-env BLAH
BLAH="B"
$

  that looks good, it's exactly what i expected given the override.
keep going ...

	test 3:

BLAH = "A"
BLAH_rday = "B"
BLAH_rday = "C"

$ bitbake-env BLAH
BLAH="C"
$

  again, so far, so good -- the second override superseded the first,
correct?

	test 4:

BLAH = "A"
BLAH_rday = "B"
BLAH_rday_append = "C"

$ bitbake-env BLAH
BLAH="B"
$

   ?????  that confuses me.  according to section 2.2.1 in bitbake
manual (very first example):

OVERRIDES = "foo"

A_foo_append = "X"

"In this case, X is unconditionally appended to the variable A_foo.
Since foo is an override, A_foo would then replace A."

according to that, i should expect BLAH to have the value "BC", no?

  more to the point, i don't see a lot of assignments of the form:

  VAR_<overridevalue>_append =

i see *loads* of

  VAR_append_<overridevalue> =

which makes much more sense.  so how is one supposed to interpret the
above based on the explanation in the current bitbake manual?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================



