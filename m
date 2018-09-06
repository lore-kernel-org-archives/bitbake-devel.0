Return-Path: <ross.burton@intel.com>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
	[209.85.218.49])
	by mail.openembedded.org (Postfix) with ESMTP id 443CD7965F
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Sep 2018 13:26:20 +0000 (UTC)
Received: by mail-oi0-f49.google.com with SMTP id c190-v6so20422948oig.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 06 Sep 2018 06:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=wp7kAHvSunNJlHNWGkdw/BkMezRG6jc7cik6yvCz+Dk=;
	b=dvDbgaGzOyXHQNtB+IPTidBCO1ajKN3VE471BICOfl/Dg7Vbd31kuTxjAE77rAQweK
	xPIFWjMtUHstRqIgK/wEqGAtXkibMkQxfbobZkrBAaIK+65/YWkzZVvuI/za15z4PPU/
	xuC122VkAJX4rJAcPu3jGEw3XLUPlXw0zJSbi49GHastQNZUJPoaoC7H++prtxxl8CVU
	ZIWoVkHUOMUdr8muGDcDQ7FGcOLdL2G8S5lhRi9QMiPAAJ1B85E7imEOuGNey6kNXgX1
	arfPb1S/oUytbn1HjFBrZr8u/aNNVGaUAlT7YbrDTFynY6mC5pl/bpZ6eRoy/4xfSYaJ
	NqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=wp7kAHvSunNJlHNWGkdw/BkMezRG6jc7cik6yvCz+Dk=;
	b=mUJ63QBV3KBt+STSYMiUwKI01ksHpusPyAapjFwGl6KO2e+8B0VIAKSroXq8ELegeD
	8HdOlRbbYwC8N0CcwTbPbxhFVJiOer3zouI0h9rZjqLIKIu57Ur/cDGNv6GHov4vup4h
	6SPf8uy3t7prk5enkjBaPdNNVesF+P5NENRnNngMUhm+I0bPD+EhA9wTk0ADil4VtYGw
	Y6M1hrB9VBMeHzjwkIRQlRdB+wIOHlXYVo2ipNYQQ0SjRkQCsnr2n+gWsOeK3UwKMIW+
	vqHhNnrzeLsVS3mH2wq0DMxllNT83Ulw3nv85luNZDsdm22SBQeQwq3kpE4o83rq+V0l
	j0qA==
X-Gm-Message-State: APzg51AA5nNiQ15Trhzu3uM7SXy2nz23D50bCCYQnpt6UxWgt0v57VEb
	C05js724/8QVO7/qG+GGLAymXttwzWzzqTkY0xQkUA==
X-Google-Smtp-Source: ANB0VdY56APP4ptq4XuFRd36RVw2TEfOMs8P24miHs+NtWXHq+CubVTJM1TMzHbglTmgiB4TWjJ1eXHOl7HbG1Xj36o=
X-Received: by 2002:aca:55cd:: with SMTP id
	j196-v6mr2742058oib.202.1536240382093; 
	Thu, 06 Sep 2018 06:26:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:385d:0:0:0:0:0 with HTTP;
	Thu, 6 Sep 2018 06:26:01 -0700 (PDT)
In-Reply-To: <1163b5cc67194ac6a07dc945f55a6670@XBOX02.axis.com>
References: <CAFCTZorDwp4OMHVAH5O13GObC6K5O700hzxV-0DjvBYPpPtZrQ@mail.gmail.com>
	<1163b5cc67194ac6a07dc945f55a6670@XBOX02.axis.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Thu, 6 Sep 2018 14:26:01 +0100
Message-ID: <CAJTo0LYbNUs48uOYMc9te9Bts6zVTGKPaagTiH9voCcf=FbHEw@mail.gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: Salaheldin Ahmed <salahuddinash@gmail.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Run bitbake with progress bar in terminal (Ubuntu 16.04)
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
X-List-Received-Date: Thu, 06 Sep 2018 13:26:21 -0000
Content-Type: text/plain; charset="UTF-8"

On 4 September 2018 at 17:43, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
> Bitbake already has very good support for displaying progress bars when
> building in a terminal (and uses it by default). You need to provide more
> information about what you have and what you are building:

Just to make this clear, this is what my bitbake is showing me right now:

Currently  5 running tasks (3397 of 3770)  90%
|#####################################################################
       |
0: python3-3.5.5-r1.0 do_compile - 408s (pid 13805)
1: linux-intel-4.14.66+gitAUTOINC+5c089e91b3_dd6a8b48d4-r0 do_deploy -
48s (pid 7249)
2: linux-intel-4.14.66+gitAUTOINC+5c089e91b3_dd6a8b48d4-r0
do_package_write_ipk - 48s (pid 7253)
3: linux-intel-4.14.66+gitAUTOINC+5c089e91b3_dd6a8b48d4-r0
do_package_write_rpm - 48s (pid 7255)
4: glib-2.0-1_2.58.0-r0 do_install - 17s (pid 31839)

The first line is, as should be obvious, a progress bar.

Ross

