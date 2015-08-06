Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 11319755F8
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Aug 2015 21:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t76L84JW023762; Thu, 6 Aug 2015 22:08:18 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wwAUXRBx7xzN; Thu,  6 Aug 2015 22:08:18 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t76L80JN023757
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 6 Aug 2015 22:08:14 +0100
Message-ID: <1438895279.30467.17.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ed Bartosh <ed.bartosh@linux.intel.com>, Michael Wood
	<michael.g.wood@intel.com>
Date: Thu, 06 Aug 2015 16:07:59 -0500
In-Reply-To: <9e6dc3ab607a3838fa86696cf2bae16cfe58bab8.1438876763.git.ed.bartosh@linux.intel.com>
References: <d5bbed667ae3585aa515d0b90329c99a62d2a3b7.1438876763.git.ed.bartosh@linux.intel.com>
	<9e6dc3ab607a3838fa86696cf2bae16cfe58bab8.1438876763.git.ed.bartosh@linux.intel.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/3] bitbake: toastergui: Move layerdetails view definition to the views.py
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
X-List-Received-Date: Thu, 06 Aug 2015 21:08:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-08-06 at 19:01 +0300, Ed Bartosh wrote:
> From: Michael Wood <michael.g.wood@intel.com>
> 
> The layerdetails view definition was moved to tables though it isn't
> a table. We have a mechanism for the JSON response for this page so use
> this instead of a custom class.
> 
> Signed-off-by: Michael Wood <michael.g.wood@intel.com>
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>

Could someone rebase and resend this patch please as it doesn't apply
with the other changes.

Cheers,

Richard


