Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8925D4660F
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 18:54:27 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2266.1768503265895496498
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 10:54:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gQYF88Wt;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a26ce6619so9688536d6.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 10:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503265; x=1769108065; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=edM6j22p8xrWvUf84VzhFmyGvOkjPOoTNbhzYiSt39I=;
        b=gQYF88WtMR2j/Ldl5sYIMYgOWd6odp0oMhJbmtzu1+QxUdZg2HQdrB7fS8riwsUuyf
         zNp/BlbUa+HK3duj0abwH1u03O4gshtWdCtaj73CE45jcOHX/9yxWEQwbbz4BN84X0Za
         IINQ+83s4EPgBV7uY9D10jb5JgrVUIHfwGr22H7kxiMWNvtdthKRU3N6mNip9fl8iowl
         r39CHlSf9PaySrdfwYspPGnF3kc+VOh7+DJWV4biICE3UPIQjfoWlxoAxraqnrvX7XM2
         wpIYw+QIkOBuZRj+k8hkr66YZSbSGLZOOLpBCC6AZiVQEuukdEvRG4+uC+JV+sU7DqOF
         ZdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503265; x=1769108065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edM6j22p8xrWvUf84VzhFmyGvOkjPOoTNbhzYiSt39I=;
        b=FGY/EX2/72ebdms0AwGBVRGTgu6lD/c/d6aBT4XpJqCStZFdEjD22Y/Shs+rv89IDV
         5mK9+Bk2RgOtn/YqliNw/XnC9qgVyH2/9Upn9Q1nKYbjTDMZdyJnU7EX53bsEzDAEJkl
         MTNWA7KufBFlMFu//Z2HBggSLoti9cwZK17okZv2liaMzDSmk0LGeGxJ4uH+toMnN5Rf
         42hQXCfwTzdxuo/ivKtL2KTaeiSN/CAVv0q3S7KpVYJ1A+S28y5yyyCIww0+U7R/mJv3
         yvJfs5gl0AYtLJiYDf256gvzgHw6P12DPJiB9PUdZq9tSbjG2mPnwac/Aad/DzV7DV3k
         X0Bw==
X-Gm-Message-State: AOJu0YyAPMEJlEmgiifHi0vC2R/tLTWXbN9a8nuXlqMqFmYXY4kr4rVe
	tS1Nb/Hfw6ILCvLCw4kuALMmgd0qerZ1ZWynd5KP8GRk2eeTSPW2lIzM9gD9303gUljV4sm/+Py
	QNUqWXKTKlCMwsvQ9+F/I2sBzL7CVpL0=
X-Gm-Gg: AY/fxX5xOH5+B4jCU7mGz/JM8qv1xugnFqNW6OlfmcwiGaaLVjnDOOI3uNZxyi6eDKv
	BWBchaHEY11mNuHA9JaDYmsVMnplaJKQAHBVk9QS5v8wv8lig077CE8XXRcOQX1v6bIPR+pri5t
	qRoiPo4uMVt4tymSUts0ccvYlN4YE4NOwLEwlwwb14GnX/gjaL7+0d7Cn5yuWlUArVbP9Y8swTE
	Y3yWdPQ6YjQLE1fPZvoTCoP+cRPFyOz9SlLIpChz1PBdo8Y+xbeJPo9zD0EkBG9VKP2+j6N
X-Received: by 2002:a05:6214:248b:b0:882:5291:23d0 with SMTP id
 6a1803df08f44-8942dd27244mr6643076d6.20.1768503264828; Thu, 15 Jan 2026
 10:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20260115182719.2066962-1-daiane.angolini@foundries.io>
In-Reply-To: <20260115182719.2066962-1-daiane.angolini@foundries.io>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 15 Jan 2026 19:54:13 +0100
X-Gm-Features: AZwV_Qjd7Za1Oe7rAQKpTR5szskTGIYSQH2iqAn8xGiXH6FI0hh8pfIizxa-Wvs
Message-ID: <CANNYZj_drbu2jCZn74BmMkt5gHmw_PUerb1ZSsfw5nVoz-DdMA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] bitbake-setup: fail if the url is not a json
To: daiane.angolini@foundries.io
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 18:54:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18791

Thanks, I think this is fine.

Alex

On Thu, 15 Jan 2026 at 19:27, Daiane Angolini via
lists.openembedded.org
<daiane.angolini=foundries.io@lists.openembedded.org> wrote:
>
> In those cases when the user enters a URL that points to the html
> representation of a json file, and not the actual json file, we can
> at least let them know that the URL point to a file which is not a json.
>
> It will help when a user copy and paste a URL from a browser and the
> tool cannot parse it as json.
>
> Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
> ---
>  bin/bitbake-setup | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index abe7614c8..f9880feb1 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -527,8 +527,12 @@ def obtain_config(top_dir, settings, args, source_overrides, d):
>          elif config_id.startswith("http://") or config_id.startswith("https://"):
>              logger.info("Reading configuration from network URI\n    {}".format(config_id))
>              import urllib.request
> -            with urllib.request.urlopen(config_id) as f:
> -              upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json.load(f)}
> +            try:
> +                with urllib.request.urlopen(config_id) as f:
> +                    json_data = json.load(f)
> +                upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json_data}
> +            except json.JSONDecodeError as e:
> +                raise Exception ("Invalid JSON from {}. Are you pointing to an HTML page? {}".format(config_id, e))
>          else:
>              logger.info("Looking up config {} in configuration registry".format(config_id))
>              registry_path = update_registry(settings["default"]["registry"], cache_dir(top_dir), d)
> --
> 2.34.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18789): https://lists.openembedded.org/g/bitbake-devel/message/18789
> Mute This Topic: https://lists.openembedded.org/mt/117284394/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

