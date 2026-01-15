Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290B6D44C51
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 14:14:14 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36565.1768486453199559626
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 06:14:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FjpnrVKf;
 spf=pass (domain: gmail.com, ip: 209.85.222.174, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c5349ba802so90654885a.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 06:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768486452; x=1769091252; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nPn2/5rC3ORBZdbrWMHZwXyPs8nBES5dAtojrgvLqfQ=;
        b=FjpnrVKf5DHBzoW5rvdJviEusrgf4vDbrfmssuCuI0NoGFuWi555CC/A8IDy43NFu8
         mT2CBQp/lbuEUFiAOxrGuhYpAx8esZoJGgkrW1EOlyMdhoUKqJGk2wmd7XiPWBHIqZ47
         Fs/EcYvRX0xzt90g4Eifg4QKVrVb3Ec6SGSzdk9lD7T7znC1BXYnnbo5Mm64C3UX2ebs
         zg1IH2cNzTSU8WXSqhvQ+LxBJerSlkIvqhUtbCiS42ANRoapgHK7ZXeGFxTxyhPGIdFD
         5044v+CwiutvhlLh9KvCF74pIHE7sOkzqfUpAsjw/y21NesifdmzOvSi/X6nIfXVpNRQ
         ebkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768486452; x=1769091252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPn2/5rC3ORBZdbrWMHZwXyPs8nBES5dAtojrgvLqfQ=;
        b=CvUaXXmNCi4+6d44n+ZXDLWN0cNvLi4br/EqmqMo3QK+Mzyj+uFH7RGoaoXxoRoT9X
         X5glxjms0XL37O0xaegzT3FaJ/FqbDw+7SdBNfmW39QHq98ioRlay5BfYRzAQdSwbqQ0
         8WiwhmjG3KSxXd/Vey3JcTnFdoSPoreemnbd3o4G1ehjOBUZ7G5PXzREP9ad7HOUWfZE
         +wyGFg6MCPHas5VgtxFoWOS4r320vGtIyCI2WU2syCZf78oixXD3mbeYrWUHlEa+c82s
         I52stDypkyUAd/UdRNiOvDW6/FZwHRFaEGZUX+dvMpww/O0fKCm5491ECAd+rh4KE6nN
         QBmw==
X-Gm-Message-State: AOJu0YzJZczhfpKbcXdftaq1kqNrINVKmkMWbNOu5tFcEMGUie56yacO
	Bj6WLwTWUGFhN/r/pOjMuaPo3/Kowcrk6f0IAbUIaY/tMzLXSSFjZcLKzn7Ae4zIJOdMYqWmNwP
	wUOAhICLFeB2Mba8ny8pmbDPV4MAIDls=
X-Gm-Gg: AY/fxX4BUqWgUIJC8kLjXSh9+wUsNPIklusCNgR1ywgMq6V+AGkiDDfpTGQpy/aYQSp
	hr2oO+oHPcazLvv2CWF7jy/1mvSoybJuDdcRHSAz2VcW53QkzqM1rxLQ2VGhKl3Wux8cmYBopHi
	EgeFt7D4Po4TTqSoj0MmbYXobIhejxzpHoJwCctcjMsP/ZTqTLbnoOzAPgsdinrhEhkkkwkDqCy
	9HuA9NTWn+oUAJX0pFKv6VcoSE3sUIu93m/ELJ2nmRjtw9gjlOheHFR47ybtLljo+1CNA==
X-Received: by 2002:a05:620a:4445:b0:8c5:2ce6:dbf with SMTP id
 af79cd13be357-8c52fb2ed87mr985891085a.17.1768486450633; Thu, 15 Jan 2026
 06:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20260115132223.2034792-1-daiane.angolini@foundries.io>
In-Reply-To: <20260115132223.2034792-1-daiane.angolini@foundries.io>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 15 Jan 2026 15:13:59 +0100
X-Gm-Features: AZwV_Qjxf_ZU0zrcuThvc-grYzhutPm8UqyIdeNpYx5u4iRYyWSbP1eAbTKYuAM
Message-ID: <CANNYZj-5nZLvez9VVz1UxYotBu3xZxY19hagxJ9srrgrBjDzng@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: verify if a configuration
 file is html
To: daiane.angolini@foundries.io
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 14:14:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18779

On Thu, 15 Jan 2026 at 14:22, Daiane Angolini via
lists.openembedded.org
<daiane.angolini=foundries.io@lists.openembedded.org> wrote:
> If the file is a html and not a json, lets notify the user.

The commit message needs a bit of additional context: when a user is
copy-pasting a URI from a browser, they need the URI to the raw JSON
data, not an HTML representation of it (as is common with web UIs to
git repositories for example). JSON decoding errors are not helpful in
that situation, so let's provide a better message.

>
> Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
> ---
>  bin/bitbake-setup | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index abe7614c8..1a1f0cdd4 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -528,7 +528,10 @@ def obtain_config(top_dir, settings, args, source_overrides, d):
>              logger.info("Reading configuration from network URI\n    {}".format(config_id))
>              import urllib.request
>              with urllib.request.urlopen(config_id) as f:
> -              upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json.load(f)}
> +                content = f.read().decode('utf-8')
> +                if content.lstrip().startswith('<!') or content.lstrip().lower().startswith('<html'):
> +                    raise Exception("Invalid configuration file: received HTML instead of JSON from {}".format(config_id))
> +                upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json.loads(f)}

if f contains valid json, then f.read() is followed by json.loads(f).
Will the second call still obtain the needed json data from f, once
it's already been read previously?

I'd suggest simply:

try:
    json_data = json.loads(f)
except json.JSONDecodeError as e:
   ... (do stuff with e.doc per
https://docs.python.org/3/library/json.html#json.JSONDecodeError)


Thanks,
Alex

