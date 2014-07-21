Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6C6EF70206
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jul 2014 18:19:21 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s6LIJ7cx022105; Mon, 21 Jul 2014 19:19:07 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GUo_oG2L3fvG; Mon, 21 Jul 2014 19:19:06 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s6LIIvgA022086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 21 Jul 2014 19:18:59 +0100
Message-ID: <1405966732.22985.104.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
Date: Mon, 21 Jul 2014 19:18:52 +0100
In-Reply-To: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB63CD@ORSMSX101.amr.corp.intel.com>
References: <cover.1404452300.git.liezhi.yang@windriver.com>
	<29052f940ce9526083a09d3ce4e665a5aa9e0db1.1404452300.git.liezhi.yang@windriver.com>
	<41DEA4B02DBDEF40A0F3B6D0DDB1237983FB63A9@ORSMSX101.amr.corp.intel.com>
	<53BA3B26.4050407@windriver.com>
	<41DEA4B02DBDEF40A0F3B6D0DDB1237983FB63CD@ORSMSX101.amr.corp.intel.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] bitbake-user-manual-intro.xml: update for dump-signatures
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
X-List-Received-Date: Mon, 21 Jul 2014 18:19:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2014-07-07 at 06:18 +0000, Rifenbark, Scott M wrote:
> Ok - if there is a problem or changes then let me know.  I have the
> doc changes pushed to poky-contrib/srifenbark/bb-manual only.  Richard
> would have to merge them from there into the upstream bitbake
> repository.

I modified Roberts patch a bit. Could you update the manual based on
that patch? I didn't take the change for the manual you have queued for
this, I'd suggest we create a new one. I did merge everything else in
your bitbake manual branch.

Cheers,

Richard


