Return-Path: <matt@madison.systems>
Received: from mail-lf0-f49.google.com (mail-lf0-f49.google.com
	[209.85.215.49])
	by mail.openembedded.org (Postfix) with ESMTP id 7739673166
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Sep 2016 20:01:06 +0000 (UTC)
Received: by mail-lf0-f49.google.com with SMTP id b199so69057118lfe.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 01 Sep 2016 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=madison-systems.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=wmnyIF0mLlt71/zPRPiyh0OEb4aiepHDQFQ2x6kekJU=;
	b=ohIsxGSbuzOB579eBZTwI4oaJrbHQq46SBSuXo/OqrbvPDuGkBSZk0T6n1fHNstQx9
	sf9MGX3KDmMBvxe7aQZPXignaP6eZy/Szgfdtx/tFcbCJieqaYHpI8SMtwt728Pc9+5o
	3Eaasc5LRbpCv2cxHkwOGP+rJqfcm8IdYHFVEKiYLlgnZ2SPO4i5/DVz8zt9imn5K/4h
	e1aKcJgMWFidhcpzV1GfHXLAIEwxa4im1wBLg3RKEJVu8hGWARRXdTkJy27LUX+CYLRL
	0EYeOfrL7lRAGFKpNaZXQhLHDVMaAgtNUqn/Ybti7uGg8cKbMjyC40ov2llHdUfhadYQ
	B/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=wmnyIF0mLlt71/zPRPiyh0OEb4aiepHDQFQ2x6kekJU=;
	b=jktlpjK3dfRqOiXjLxC/AegKJdkrx+vqywMNxbKAq6dS1u0dt+1mczAuajWyMcFe4v
	vdUlUUHWGndAoZCekYpnIcLMB/nuz+/sNXn1Vf4od0TfK2xGIvCWYZ9JJN2Ex07akOYe
	GjLiGcs9sNjeXHJFw+FMLXPpNU7FN3yKwEOH+WERnSn/WSaYzSBkAzvOE/yQ5iM8haK9
	UPhG3xC4VMAaNACGNZcQbcNTslF5AwfE5ssGeoLXix9LzJqAQXVGAZArCQ489SxUTaVs
	KSQUs+B7EtxvcWD3JOvPBjn9WpbgFXJAJ1qQJXqGG1c21wgfWUmFW656h21HLrN+TNvG
	JJGQ==
X-Gm-Message-State: AE9vXwOtUbTfv2nGZNRhoV0Aq8I4swS61ULgbfWkRwlIJh0n6As77raxx/wdgF9uBW2baGEKq5RlGqU8KORR7A==
X-Received: by 10.46.71.69 with SMTP id u66mr5510909lja.14.1472760066935; Thu,
	01 Sep 2016 13:01:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.24.162 with HTTP; Thu, 1 Sep 2016 13:01:06 -0700 (PDT)
In-Reply-To: <1472673428-16400-1-git-send-email-kergoth@gmail.com>
References: <1472673428-16400-1-git-send-email-kergoth@gmail.com>
From: Matt Madison <matt@madison.systems>
Date: Thu, 1 Sep 2016 13:01:06 -0700
Message-ID: <CAGgRHJri42PNhxkMSa+odU5sVTTU+mLLpUknaJ0oS19Hd8x00A@mail.gmail.com>
To: Christopher Larson <kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bb.fetch2.svn: correctly pass workdir when fetching
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
X-List-Received-Date: Thu, 01 Sep 2016 20:01:07 -0000
Content-Type: text/plain; charset=UTF-8

Thanks.  I think that's the only instance I missed.

-Matt

On Wed, Aug 31, 2016 at 12:57 PM, Christopher Larson <kergoth@gmail.com> wrote:
> From: Christopher Larson <chris_larson@mentor.com>
>
> The ud.pkgdir argument was being passed as the 'quiet' argument to
> runfetchcmd, not the 'workdir' argument, resulting in fetching the svn module
> into the root of DL_DIR, not where it belongs.
>
> Cc: Matt Madison <matt@madison.systems>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> ---
>  lib/bb/fetch2/svn.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
> index 9ff9410..6ca79d3 100644
> --- a/lib/bb/fetch2/svn.py
> +++ b/lib/bb/fetch2/svn.py
> @@ -141,7 +141,7 @@ class Svn(FetchMethod):
>              bb.utils.mkdirhier(ud.pkgdir)
>              logger.debug(1, "Running %s", svnfetchcmd)
>              bb.fetch2.check_network_access(d, svnfetchcmd, ud.url)
> -            runfetchcmd(svnfetchcmd, d, ud.pkgdir)
> +            runfetchcmd(svnfetchcmd, d, workdir=ud.pkgdir)
>
>          scmdata = ud.parm.get("scmdata", "")
>          if scmdata == "keep":
> --
> 2.8.0
>

