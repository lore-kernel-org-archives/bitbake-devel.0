Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 465B77F89C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Nov 2019 08:46:12 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id g7so4946456wrw.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Nov 2019 00:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=TRk4PA2mCIYNHCl3dv0UuH/BOKoRix5Ja9QcWct1YvY=;
	b=G6hwIT1uYXqkaPlPp4bAE4cc0k0ODLO6ygxajsCvSYLFRwyv+YK9JrnuC4YY75BsC0
	0bnvS+HDVUMmMzGcCVJ5xDruwC8QYq4BQDBZ5BVseavRwtB6Bh0tVPk/tKm5mQgU9rH8
	BWTmATJJbueDREiA04cmUFN6R5s3gq3+TXKW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=TRk4PA2mCIYNHCl3dv0UuH/BOKoRix5Ja9QcWct1YvY=;
	b=A4Wdah+aRSsuKLfcZ+Ut9jUHIhrwWA9pIiZ0LUH9Q4AXGRM5YMAzMQdHFa3G8ZI54g
	8motpdegNS0dkHy00Jz4aZZuZj9F6uTrWaDmUEWg5uehzEQ1+oWgiTmNApFySviqOwat
	ivdlRcfxnVR5DbM9J1QF4hOzJJuYu/pVoczd54vctWZjArM1ak7/MUSO3XPv/QBswI+i
	5oIFjTOA5kWlw5j89BeVr+HnaxLw4adskEIRXyrolzVoV0sDMuiSpA7kHBkZxWfspodB
	3i0vgUfSGInjkBvYsp1S0fT/OhYLzKYU1s4aI0NlnPoIbKRzy144yUotVvqE+W32OMiy
	JSvw==
X-Gm-Message-State: APjAAAXGig7woRTcE3rpXdPzUQgpRNF21c1q4iBu92UU+TlG4GJbV/BQ
	R2pEd+CcmuBqzhUpX5o02twZfI2fenc=
X-Google-Smtp-Source: APXvYqxslLUFEw5suXbsR566E+T4qpC00nE/5kww/2XZEjcNN/n6gnXNhKaiQnFGpS/Pjy4BdDUMzw==
X-Received: by 2002:adf:d091:: with SMTP id y17mr43172408wrh.182.1574844372831;
	Wed, 27 Nov 2019 00:46:12 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	i127sm6265408wma.35.2019.11.27.00.46.11
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 27 Nov 2019 00:46:12 -0800 (PST)
Message-ID: <7053deffb03494b86767153124fe061f423d6110.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Reyna, David" <david.reyna@windriver.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "akuster (akuster@mvista.com)"
	<akuster@mvista.com>
Date: Wed, 27 Nov 2019 08:46:10 +0000
In-Reply-To: <5E53D14CE4667A45B9A06760DE5D13D0FAE91779@ALA-MBD.corp.ad.wrs.com>
References: <5E53D14CE4667A45B9A06760DE5D13D0FAE91779@ALA-MBD.corp.ad.wrs.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [ZEUS][MASTER] [PATCH 2/2] toaster: improve warnings when adding	dependency to packages
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
X-List-Received-Date: Wed, 27 Nov 2019 08:46:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi David,

As far as I can tell, this was already merged back in October:

http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake?id=97a5762be1c8da4092ba7e51dbd46a0c8b9764e8

and therefore should be in master and zeus already?

Cheers,

Richard

On Wed, 2019-11-27 at 00:43 +0000, Reyna, David wrote:
> Hi Richard,
> 
> As we discussed at ELCE, I am putting this back on the top of your
> list. This was the missed patch for Zeus.
> 
> I am hoping that it gets merged to 3.0.1 and to master.
> 
> Thanks,
> David
> 
> 
> -----Original Message-----
> From: Reyna, David 
> Sent: Tuesday, October 15, 2019 8:09 AM
> To: bitbake-devel@lists.openembedded.org; 
> richard.purdie@linuxfoundation.org
> Cc: Reyna, David
> Subject: RE: [bitbake-devel] [PATCH 2/2] toaster: improve warnings
> when adding dependency to packages
> 
> Hi Richard,
> 
> This is the second of two patches that I sent. The first one got
> merged but this one did not.
> 
> - David
> 
> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:
> bitbake-devel-bounces@lists.openembedded.org] On Behalf Of David
> Reyna
> Sent: Tuesday, October 01, 2019 4:18 PM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 2/2] toaster: improve warnings when
> adding dependency to packages
> 
> From: David Reyna <David.Reyna@windriver.com>
> 
> Some of the objects that bitbake reports to Toaster as dependencies
> to packages
> are known objects that are not packages, for example library files
> and kernel
> modules. In the Toaster logs, mark these as "Info" instead of
> "Warning".
> 
> [YOCTO #13386]
> 
> Signed-off-by: David Reyna <David.Reyna@windriver.com>
> ---
>  lib/bb/ui/buildinfohelper.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/lib/bb/ui/buildinfohelper.py
> b/lib/bb/ui/buildinfohelper.py
> index f2151c2..5cbca97 100644
> --- a/lib/bb/ui/buildinfohelper.py
> +++ b/lib/bb/ui/buildinfohelper.py
> @@ -646,6 +646,9 @@ class ORMWrapper(object):
>                  Target_Installed_Package.objects.create(target =
> target_obj, package = packagedict[p]['object'])
>  
>          packagedeps_objs = []
> +        pattern_so = re.compile(r'.*\.so(\.\d*)?$')
> +        pattern_lib = re.compile(r'.*\-suffix(\d*)?$')
> +        pattern_ko = re.compile(r'^kernel-module-.*')
>          for p in packagedict:
>              for (px,deptype) in packagedict[p]['depends']:
>                  if deptype == 'depends':
> @@ -654,6 +657,13 @@ class ORMWrapper(object):
>                      tdeptype = Package_Dependency.TYPE_TRECOMMENDS
>  
>                  try:
> +                    # Skip known non-package objects like libraries
> and kernel modules
> +                    if pattern_so.match(px) or
> pattern_lib.match(px):
> +                        logger.info("Toaster does not add library
> file dependencies to packages (%s,%s)", p, px)
> +                        continue
> +                    if pattern_ko.match(px):
> +                        logger.info("Toaster does not add kernel
> module dependencies to packages (%s,%s)", p, px)
> +                        continue
>                      packagedeps_objs.append(Package_Dependency(
>                          package = packagedict[p]['object'],
>                          depends_on = packagedict[px]['object'],
> -- 
> 1.9.1
> 


