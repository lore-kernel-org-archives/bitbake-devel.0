Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7A17B75D48
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Oct 2015 11:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9OBQLjT029249; Sat, 24 Oct 2015 12:26:21 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id k4Vy4JCT8ALj; Sat, 24 Oct 2015 12:26:21 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9OBQ6Ob029246
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 24 Oct 2015 12:26:17 +0100
Message-ID: <1445685965.21913.58.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Smith, Elliot" <elliot.smith@intel.com>
Date: Sat, 24 Oct 2015 12:26:05 +0100
In-Reply-To: <CA+1hgUg7=OhPXV=fHrXzLpSeWKZekx0BkYpu1BC8zaA1H7gG2w@mail.gmail.com>
References: <1444555346.14364.24.camel@linuxfoundation.org>
	<CA+1hgUj5Lty=V_jSWE1YA2CPJuaY5-PAoj+P8gEtzSKDN5gVjA@mail.gmail.com>
	<1445011191.17974.34.camel@linuxfoundation.org>
	<CA+1hgUg7=OhPXV=fHrXzLpSeWKZekx0BkYpu1BC8zaA1H7gG2w@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker: Ensure BB_CONSOLE remains correct over server resets
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
X-List-Received-Date: Sat, 24 Oct 2015 11:26:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-10-19 at 13:27 +0100, Smith, Elliot wrote:
> Thanks for clarifying.
>
> Will these patches be in 2.0? From the toaster point of view, it would
> be better if the current behaviour remained for now, even though it is
> broken.
>
> We are working on a solution which will write separate build logs from
> within Toaster itself, which will mean we can keep our log download
> working when your patches do go in.
>
> However, we may not get this finished for 2.0, and it would be good if
> we could keep the Toaster log download feature working in the
> meantime.
> 
Given the other discussion I've seen, I'm assuming it would be ok to
merge these now?

Cheers,

Richard




