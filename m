Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 268D265CBC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 07:50:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t7H7nidr024088; Mon, 17 Aug 2015 08:50:02 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DpktHf461bdO; Mon, 17 Aug 2015 08:50:02 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t7H7nndp024091
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 17 Aug 2015 08:50:00 +0100
Message-ID: <1439797789.1218.38.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Michael Wood <michael.g.wood@intel.com>
Date: Mon, 17 Aug 2015 08:49:49 +0100
In-Reply-To: <cover.1439375393.git.michael.g.wood@intel.com>
References: <cover.1439375393.git.michael.g.wood@intel.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: Re: [PATCH 0/2] Toaster patches
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
X-List-Received-Date: Mon, 17 Aug 2015 07:50:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2015-08-12 at 11:32 +0100, Michael Wood wrote:
> Reviewed by Michael Wood
> 
> The following changes since commit a8b723498c9a7106210db140452886894494b4d6:
> 
>   bitbake: cooker: Resolve file monitoring race issues when using memres bitbake (2015-08-03 07:36:25 +0100)
> 
> are available in the git repository at:
> 
>   git://git.yoctoproject.org/poky-contrib michaelw/submit/bbarrosp/misc
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=michaelw/submit/bbarrosp/misc
> 
> Alexandru DAMIAN (1):
>   bitbake: toaster: fix invalid fields in the package details page
> 
> Belen Barros Pena (1):
>   Fix typo in set up script output

I merged these however I would note that the prefixes in the shortlogs
are becoming a little inconsistent with the recent toaster patches. I
added in a toaster: and removed a bitbake: in this case.

Cheers,

Richard


