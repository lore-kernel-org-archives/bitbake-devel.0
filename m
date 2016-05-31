Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id EC73C77175
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 May 2016 13:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4VDo2pL017387; Tue, 31 May 2016 14:50:15 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nxTC4T4iVcUS; Tue, 31 May 2016 14:50:15 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4VDoD0X017395
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 May 2016 14:50:14 +0100
Message-ID: <1464702613.3814.2.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: fabien.proriolpatch@kazoe.org, bitbake-devel@lists.openembedded.org
Date: Tue, 31 May 2016 14:50:13 +0100
In-Reply-To: <1464700684-24169-1-git-send-email-fabien.proriolpatch@kazoe.org>
References: <1464700684-24169-1-git-send-email-fabien.proriolpatch@kazoe.org>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: Fabien Proriol <fabien.proriol@jdsu.com>
Subject: Re: [PATCH] bb.fetch.git: add a way to avoid git protocol, and force http or https mirrors
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
X-List-Received-Date: Tue, 31 May 2016 13:50:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2016-05-31 at 15:18 +0200, fabien.proriolpatch@kazoe.org wrote:
> From: Fabien Proriol <fabien.proriol@jdsu.com>
> 
> This patch add the possibility to bitbake to avoid git protocol to
> fetch sources.
> This is usefull in some network with firewall blocking git port.
> 
> When BB_GIT_PROTOCOL_FIREWALL is set, the PROTOCOL_MIRRORS table is
> used to find the new protocol (http or https) and the new host (if
> different) to used.
> 
> BB_GIT_PROTOCOL_FIREWALL can also contains a list of host accepted.
> This is usefull for exemple, if we use local git repository inside
> the network.
> 
> Exemple usage:
>     # Avoid all git protocol
>     BB_GIT_PROTOCOL_FIREWALL = "1"
> 
>     # Avoid git protocol, except for srv1 and srv2 in local network
>     BB_GIT_PROTOCOL_FIREWALL = "srv1.mydomain.com;srv2.mydomain.com"

Why not use the more generic MIRRORS and PREMIRRORS for this? If they
can't support this, we likely should figure out a way to make them work
for it rather than adding new fetcher specific variables.

Cheers,

Richard

