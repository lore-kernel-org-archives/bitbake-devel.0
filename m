Return-Path: <open.source@oleksandr-kravchuk.com>
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
	[209.85.208.196])
	by mail.openembedded.org (Postfix) with ESMTP id 788AB7E8F6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Jun 2019 00:09:57 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id x25so522835ljh.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Jun 2019 17:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oleksandr-kravchuk-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=MxB04ojfs8UhEs0Wr+VhIbk9uNSz2oipw8OvjEO4gf8=;
	b=m4+JnW0woqcvAs7E/LTOc3WDtkWLSYnr+b2X+Ox9O43FmAXACtRY9TBv12hXwYqsxg
	2sRRfdjSy3wyanBcho+T96A2SvdAuqET5q2xsdY2LhXPslEGg7MfqtjGvAnYvcQYnT1N
	YJV55n//s5RIwxqlcYkau0a4g4dEDW96SFxMDtO8/x0WCG6hZGiKjqU8jiZdwCFgR/Bf
	haslbRhLsFVXFyg/8nRNS8dsjX+qLp9MKFfAGxaM72vSIaEEO1PfSAUrmJemZqS00/S6
	dEK3diRKKb3I5Ogo5oZteGkQJ1g06qsNQsZW8FTvsfAqC+AWDQU5APMig0rRMP6WiHiK
	TPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=MxB04ojfs8UhEs0Wr+VhIbk9uNSz2oipw8OvjEO4gf8=;
	b=LwksEPid+rzV5xoTGD72uHt+YIb4NiFvcQE/3hONjQP5dW1bfoeibSIhRPQ3N9ehLv
	yxH/g8YXSJXHll+LMHBqk71T58m70SxKCKs7qeX9dOs1vfbvOibsksjSEBvr1gEVUiWS
	yB65N1i5ndxdZx4oQFdiv6HqBEhEbeWrxjOr/iczow7B5tvlQpH3iO7aEG83B/3ylx2Q
	x5KWR16B/Hp6Eo6LHi4Wyo3YuCzwp0dRWIpyJpgXVtkSf1ukVuN35nbqxoUJUHsS7TAx
	bp1Is8ALuHGp9l6hXWraIZ6atTsCy8RrL2FqeGqk5evq9VQ7b5Mk7VeWYcbf4zCthYJI
	dnvg==
X-Gm-Message-State: APjAAAXHroafH7MTdmBJWDiYEl19xNtYnGxjapt/VO/02kPRQ8UE7zXX
	MDPWwtCtvZpuhXDC/r942Yzed9LcA5w=
X-Google-Smtp-Source: APXvYqzG+aSqKnabRIBjFNP4lumX2LF2e7Yikf+NUN8Wit7CkwtzhNTC7TUPNhkMpTrI3srzcG/mHA==
X-Received: by 2002:a2e:8495:: with SMTP id b21mr7906104ljh.149.1560470997850; 
	Thu, 13 Jun 2019 17:09:57 -0700 (PDT)
Received: from [192.168.0.8] (c83-252-117-108.bredband.comhem.se.
	[83.252.117.108])
	by smtp.gmail.com with ESMTPSA id q2sm249185ljq.74.2019.06.13.17.09.57
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Jun 2019 17:09:57 -0700 (PDT)
To: bitbake-devel@lists.openembedded.org
References: <20190614000925.12048-1-open.source@oleksandr-kravchuk.com>
From: Oleksandr Kravchuk <open.source@oleksandr-kravchuk.com>
Message-ID: <f13ae5e7-a356-f42e-0efc-020f5ee29cb0@oleksandr-kravchuk.com>
Date: Fri, 14 Jun 2019 02:09:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614000925.12048-1-open.source@oleksandr-kravchuk.com>
Subject: Re: [PATCH] bitbake: cooker: list all nonexistent bblayer directories
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
X-List-Received-Date: Fri, 14 Jun 2019 00:09:57 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US

This is how log will look like:

ERROR: Unable to start bitbake server (None)
ERROR: Server log for this session
(/home/sashko/projects/yocto/open-embedded/build/bitbake-cookerdaemon.log):
--- Starting bitbake server pid 11745 at 2019-06-14 02:08:15.687299 ---
ERROR: The following layer directories do not exist:
ERROR:    /home/sashko/projects/yocto/open-embedded/sources/poky/meta-abc
ERROR:    /home/sashko/projects/yocto/open-embedded/sources/poky/meta-xyz
ERROR: Please check BBLAYERS in
/home/sashko/projects/yocto/open-embedded/build/conf/bblayers.conf

On 14/06/2019 02:09, Oleksandr Kravchuk wrote:
> Check existence of all the bblayer direcotories at once and print them
> all, so if there are multiple nonexistent directories, user does not
> have to correct bblayers.conf and restart bitbake multiple times.
>
> [YOCTO #11647]
>
> Signed-off-by: Oleksandr Kravchuk <open.source@oleksandr-kravchuk.com>
> ---
>  bitbake/lib/bb/cookerdata.py | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
> index f8ae41093b..842275d530 100644
> --- a/bitbake/lib/bb/cookerdata.py
> +++ b/bitbake/lib/bb/cookerdata.py
> @@ -342,14 +342,24 @@ class CookerDataBuilder(object):
>              data = parse_config_file(layerconf, data)
>  
>              layers = (data.getVar('BBLAYERS') or "").split()
> +            broken_layers = []
>  
>              data = bb.data.createCopy(data)
>              approved = bb.utils.approved_variables()
> +
> +            # Check whether present layer directories exist
>              for layer in layers:
>                  if not os.path.isdir(layer):
> -                    parselog.critical("Layer directory '%s' does not exist! "
> -                                      "Please check BBLAYERS in %s" % (layer, layerconf))
> -                    sys.exit(1)
> +                    broken_layers.append(layer)
> +
> +            if broken_layers:
> +                parselog.critical("The following layer directories do not exist:")
> +                for layer in broken_layers:
> +                    parselog.critical("   %s", layer)
> +                parselog.critical("Please check BBLAYERS in %s" % (layerconf))
> +                sys.exit(1)
> +
> +            for layer in layers:
>                  parselog.debug(2, "Adding layer %s", layer)
>                  if 'HOME' in approved and '~' in layer:
>                      layer = os.path.expanduser(layer)

