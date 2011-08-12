Received: from mx3.leapfrog.com ([63.114.26.253])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dlazzari@leapfrog.com>) id 1Qrw7q-0002ER-4s
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 20:06:30 +0200
Received: from mx3.leapfrog.com (localhost [127.0.0.1])
	by localhost.leapfrog.com (Postfix) with ESMTP id 9D39F5EE0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Aug 2011 11:01:31 -0700 (PDT)
Received: from naemhtcas01.na.leapfrog.com (unknown [10.12.1.51])
	by mx3.leapfrog.com (Postfix) with ESMTP id 7EF8D5ED8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Aug 2011 11:01:31 -0700 (PDT)
Received: from naemmail08.na.leapfrog.com ([10.11.5.92]) by
	naemhtcas01.na.leapfrog.com ([10.12.1.51]) with mapi; Fri, 12 Aug 2011
	11:01:31 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: "'bitbake-devel@lists.openembedded.org'"
	<bitbake-devel@lists.openembedded.org>
Date: Fri, 12 Aug 2011 11:01:30 -0700
Thread-Topic: [RFC] Do postfiles make sense?
Thread-Index: AcxY1gZWGZAhsJCAQ+ehQ5M/1Yk2cwAQZBxA
Message-ID: <359B10B9B28B294BAA6405D9320312E0111E934078@naemmail08.na.leapfrog.com>
References: <mailman.15.1313143204.31105.bitbake-devel@lists.openembedded.org>
In-Reply-To: <mailman.15.1313143204.31105.bitbake-devel@lists.openembedded.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
Subject: Re: [RFC] Do postfiles make sense?
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
X-List-Received-Date: Fri, 12 Aug 2011 18:06:30 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


>-----Original Message-----
>Date: Thu, 11 Aug 2011 16:27:34 -0700
>From: Joshua Lock <josh@linux.intel.com>
>Subject: [bitbake-devel] [RFC] Do postfiles make sense?
>To: bitbake-devel@lists.openembedded.org
>Message-ID: <1313105254.2506.8.camel@vorpal.jf.intel.com>
>Content-Type: text/plain; charset=3D"UTF-8"
>
>All,
>
>Some time ago I added an -R switch to bitbake for configuration files to
>load after bitbake.conf[1].
>
>I'd been happily using this for the UI I've been working on without
>fully realising that it's not safe to rely on postfiles to set variables
>which affect the files included by bitbake.conf. For oe-core this
>includes: BUILD_SYS, TARGET_SYS, MACHINE, SDKMACHINE and DISTRO.
>
>In light of this flaw do postfiles make sense?
>
>For the UI's purpose I think I'm going to have to switch to a prefile
>(-r) in the wrapper script and add logic to hob to detect whether the
>set variables differ from those in hob.local.conf - so that we can warn
>those with a local.conf that uses =3D assignment that things won't work...
>
>Thoughts? Suggestions?
>
>Thanks,
>Joshua
>
>1.
>http://git.openembedded.org/cgit.cgi/bitbake/commit/?id=3Da8246ae5400c23df
>0d3ee29c36f4d9f257d1e6d1
>--
>Joshua Lock
>        Yocto Project "Johannes Factotum"
>        Intel Open Source Technology Centre
>

I actually have a decent use case for a postfile. We have several in house =
recipes that use an SVN repo for their SRC_URI. The URI contains a variable=
 that points to what branch to build from. So the recipes default to pullin=
g the head revision of trunk. It's nice to be able to have a collection of =
different conf files that we can post load to override the branch and revis=
ion variables without having to change the recipes themselves. So we have l=
ike a Release1.1.conf file that when post loaded builds Release 1.1 from th=
e correct branches and revisions. We can do this with -r by using BRANCH ?=
=3D "TRUNK" in the recipes (that's how we did it in OE Classic), but when w=
e sometimes forgot the question mark, it would end up building TRUNK no mat=
ter what was in the conf file.


