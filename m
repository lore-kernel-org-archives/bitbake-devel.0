Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3E857774F3
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jun 2016 10:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u53Ac5hc001790; Fri, 3 Jun 2016 11:38:05 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HDE5TO19dgJv; Fri,  3 Jun 2016 11:38:05 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u53Ac1SH001778
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 3 Jun 2016 11:38:02 +0100
Message-ID: <1464950281.13979.13.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Burton, Ross" <ross.burton@intel.com>, Andrew Bradford
	<andrew@bradfordembedded.com>
Date: Fri, 03 Jun 2016 11:38:01 +0100
In-Reply-To: <CAJTo0LbvONwNTroCJrJ8K1MP1zJ_98g-NrWw7SbNfeOp94nQGA@mail.gmail.com>
References: <1464205704-26377-1-git-send-email-andrew@bradfordembedded.com>
	<1464205704-26377-2-git-send-email-andrew@bradfordembedded.com>
	<CAJTo0LbvONwNTroCJrJ8K1MP1zJ_98g-NrWw7SbNfeOp94nQGA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Andrew Bradford <andrew.bradford@kodakalaris.com>
Subject: Re: [PATCH 1/2] perforce fetcher: Rework to support SRCREV and P4CONFIG
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
X-List-Received-Date: Fri, 03 Jun 2016 10:38:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2016-06-03 at 10:47 +0100, Burton, Ross wrote:
> Master has just landed the Python3 port, so can you rebase this to
> current git master?

I replied to the OE-Core patches and I think that will mean there are
some changes needed to this patch too so that can all hopefully be
rolled together in the next version of the patch.

Cheers,

Richard

