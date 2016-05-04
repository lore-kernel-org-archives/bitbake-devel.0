Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5E1DE6E630;
	Wed,  4 May 2016 08:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u448uJYL021439; Wed, 4 May 2016 09:56:19 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MbmRxibqH6XH; Wed,  4 May 2016 09:56:19 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u448uG7e021436
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 4 May 2016 09:56:17 +0100
Message-ID: <1462352176.18407.11.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 04 May 2016 09:56:16 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Python 3 for Bitbake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 04 May 2016 08:56:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We've come to a cross roads for bitbake and python. Currently we run on
python 2.7 but python 2.x is getting old and we really need to move to
3.X.

Whilst there are a number of tools out there which can translate
between the two, we have the complexity that we have python both in
bitbake itself and spread throughout the metadata. We could try and
migrate, attempting to support both versions but it would require a lot
of effort and I'm not sure we get much return for it. Its more likely
we'd end up with a lot of subtle bugs.

An alternative is we just have a flag day and switch, putting in
patches to bitbake and the metadata to migrate to 3.X in one go. The
advantage of this is much cleaner code without any workarounds for
compatibility.

I did some work on this a couple of years ago, I've dusted off those
patches and improved upon them to get to the ones in:

http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=rpurdie/wip

Right now, this is enough to be able to run "bitbake bash", there are a
ton of things which still need to be done. The patches above are rather
rough, the aim just being to find out if we can get the basics working
which it appears we can.

My proposal is we decide to have the flag day, we queue up the patches
on a python3 branch both in oe-core and bitbake, then we switch when we
get successful autobuilder builds. I'd ideally like to do this quite
soon and get one with it (within a few weeks), leaving plenty of time
to handle issues and the other changes planned for this release cycle
and give other layers time to adapt.

I will likely push things so the basics in the core work, I'll then
need help for things like toaster, the QA framework, the supporting
tools (devtool, recipetool and so on).

Does anyone object to this?

Cheers,

Richard




