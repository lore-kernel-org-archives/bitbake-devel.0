Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A0315770EF
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Apr 2016 13:36:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u35DaNbW029903; Tue, 5 Apr 2016 14:36:23 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id A-Z5-8WzKv42; Tue,  5 Apr 2016 14:36:23 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u35DaLkW029900
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 5 Apr 2016 14:36:22 +0100
Message-ID: <1459863381.7348.163.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 05 Apr 2016 14:36:21 +0100
In-Reply-To: <422c156e028c615327a780b83db657ba68259549.1459852436.git.liezhi.yang@windriver.com>
References: <cover.1459852436.git.liezhi.yang@windriver.com>
	<422c156e028c615327a780b83db657ba68259549.1459852436.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] fetch2/git.py: remove .indirectiondir workaround
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
X-List-Received-Date: Tue, 05 Apr 2016 13:36:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2016-04-05 at 03:35 -0700, Robert Yang wrote:
> It was used for workaround git 1.7.9.2 which was released in 2012
> which
> should not be existed on nowadays host, so remove it to avoid
> confusions.

I like the idea of this however:

$ cat classes/sanity.bbclass | grep 7.8
# We use git parameters and functionality only found in 1.7.8 or later
    if LooseVersion(version) < LooseVersion("1.7.8"):
        return "Your version of git is older than 1.7.8 and has bugs
which will break builds. Please install a newer version of git.\n"

so we have a minimum version of 1.7.8 defined right now...

I'd be ok merging this if we increase the minimum version requirement.

Cheers,

Richard

