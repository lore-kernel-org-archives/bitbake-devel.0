Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B5607763FF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 19:38:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6SJcGjb024533; Tue, 28 Jul 2015 20:38:16 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ESScnU0VxXq3; Tue, 28 Jul 2015 20:38:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6SJc00j024515
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 28 Jul 2015 20:38:11 +0100
Message-ID: <1438112280.11208.39.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Bystricky, Juro" <juro.bystricky@intel.com>
Date: Tue, 28 Jul 2015 20:38:00 +0100
In-Reply-To: <6E51916E4A1F32428260031F4C7CD2B6101D2AA9@ORSMSX109.amr.corp.intel.com>
References: <1437849163-1577-1-git-send-email-juro.bystricky@intel.com>
	<1438081047-sup-2928@axis.com>
	<6E51916E4A1F32428260031F4C7CD2B6101D2AA9@ORSMSX109.amr.corp.intel.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] wget.py: support for semi-colons in URL
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
X-List-Received-Date: Tue, 28 Jul 2015 19:38:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2015-07-28 at 16:06 +0000, Bystricky, Juro wrote:
> I tested your suggestion (replacing ";" with "&" in the SRC_URI ) and in my case it did work properly.
> So even if this may not solve everything, I believe this should be properly documented somewhere
> as this seems to be currently the only way to use SRC_URI with semi-colons in URL.
> 
> Note that one still needs to specify the downloaded file name manually, i.e.
> 
> SRC_URI = "http://abc123.com/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47; downloadfilename=myfile.bz2"

A patch adding some comments about this to wget.py would be nice, as
would a patch documenting it in the bitbake manual...

Cheers,

Richard


