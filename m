Return-Path: <ross.burton@intel.com>
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
	[209.85.192.45])
	by mail.openembedded.org (Postfix) with ESMTP id 6BB7A6A9D4
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Oct 2014 13:14:33 +0000 (UTC)
Received: by mail-qg0-f45.google.com with SMTP id q107so1916139qgd.18
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 09 Oct 2014 06:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=O0fQ9ALKDAuu7x59zMx7hcd2VaPc15Yvwsgo9PeFgR8=;
	b=kvxoFAgXA/y1cMN3Qw4Z1UtN3p3TZFlE0fKqGnVk5BX5LgSeYvH5Xq7VmE3dGQlxGm
	TjszvdmoZZrToM4Rm6T0sTmX8ojYXPFXnXhsBa7ncXEzifg1UlOKJD/SrGiVpThXcnKD
	oP3GFUIst+anHnXFtGApVkrivebCmPACpp0SGGPAMWzgQxut1Abgi7n4OyPF2EoPBVva
	+owS5qSPDBfHu2AnewnORx9F28BhcKcI1fHjIMbQJwoeqF+puK2owmwQY+tffAS0z4Tf
	0v1hPZNJWRos8LtDSOSJr6Dh45BoWmcX5+hXRwteYbkoD9HFJVni1telTrZyJg1X227H
	6nqg==
X-Gm-Message-State: ALoCoQkNnOiaGfQptQqLdC/ejZB1s+sR599EjrF00qMMHMvmFRAOn0BrLJAgfEWQCEA28jX6CJF+
X-Received: by 10.140.105.195 with SMTP id c61mr54867092qgf.15.1412860474670; 
	Thu, 09 Oct 2014 06:14:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.106.134 with HTTP; Thu, 9 Oct 2014 06:14:14 -0700 (PDT)
In-Reply-To: <C62CE9D6-CFC7-4D06-A28F-FA3536E9A2D6@gmail.com>
References: <C62CE9D6-CFC7-4D06-A28F-FA3536E9A2D6@gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Thu, 9 Oct 2014 14:14:14 +0100
Message-ID: <CAJTo0Lb4-WKRBfqy=VRw4ik-7mRxZX7rQ=QWY+dGUi3=8z08NA@mail.gmail.com>
To: Manuel Piroz <succes.incorporated@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: help
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
X-List-Received-Date: Thu, 09 Oct 2014 13:14:36 -0000
Content-Type: text/plain; charset=UTF-8

On 9 October 2014 13:43, Manuel Piroz <succes.incorporated@gmail.com> wrote:
> // This is The beginning of the build
>
>
>
>
>
>
> // this is the END

There should be messages in that gap...  Luckily the entire log is
saved to disk, in tmp/log/cooker/[MACHINE]/[TIMESTAMP] so you can
re-run it and then read the full log. This should hopefully tell you
what the 1 warning and 2 errors were.

Ross

