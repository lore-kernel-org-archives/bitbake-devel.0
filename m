Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id B665073D46
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Nov 2015 22:48:25 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 03 Nov 2015 14:47:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,240,1444719600"; d="scan'208";a="826189173"
Received: from lsandov1-mobl-linux.zpn.intel.com (HELO [10.219.5.41])
	([10.219.5.41])
	by fmsmga001.fm.intel.com with ESMTP; 03 Nov 2015 14:47:27 -0800
Message-ID: <56393A0F.5040407@linux.intel.com>
Date: Tue, 03 Nov 2015 16:49:51 -0600
From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To: =?UTF-8?B?Sm/Dq2wgRXNwb25kZQ==?= <joel.esponde@gmail.com>, 
	bitbake-devel@lists.openembedded.org
References: <1446588511-16158-1-git-send-email-joel.esponde@gmail.com>
In-Reply-To: <1446588511-16158-1-git-send-email-joel.esponde@gmail.com>
Subject: Re: [PATCH] Bitbake hob's image detail page should be able to display big logs with display resolution like 1600x900. Freescale yocto project is producing big logs for example.
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
X-List-Received-Date: Tue, 03 Nov 2015 22:48:26 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/03/2015 04:08 PM, Joël Esponde wrote:
> Moved log boxes into ScrolledWindows to keep them with a small size while being able to display big logs.
> Changed buttons alignment from y centered to top for them to be visible directly on first show.

you may need to truncate your one-line patch description (summary) in 
order to be accepted. You can include this info on the detailed 
description area.

>
> Signed-off-by: Joël Esponde <joel.esponde@gmail.com>
> ---

