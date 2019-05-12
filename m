Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 76D137DFE4
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 May 2019 08:28:06 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id w12so11928303wrp.2
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 May 2019 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=ygM9FApa2jfIgVoTTzdGGYvg4cHATaeF+UCHMH1F83k=;
	b=b9fJ5m4nKJwCKrhmQxbbNkT/w3mb1c9vMKvVz6OGwERg6sOzTxigoRaP0dFVC+buXC
	kr3eCQjKlTxtybnA+ngGqIOsHM0LqARYdWhNY0EUz/nylxxFU5AmDG9Sq8p+Xagjngm4
	cIDuRX5glWGUltm684ui09V5gzILsAhlseakE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=ygM9FApa2jfIgVoTTzdGGYvg4cHATaeF+UCHMH1F83k=;
	b=IB9tgRqChB3L5ZCJ0fL7pv6ifDpZ1HYXGueX4vRMZ1+rYaX/WQ+iRta5k6Kgut87cC
	N6Mfqq61pju26A/0lWUifQoDm7jaT66vu62FIL6J8U/n9tN3FmhvW+72SajPefNr1zlc
	NktZCweuCg2AmjmWFP3nPB/hEwoeq5Rj6jBIK3cKtWlF7uCulPU4k8FWZDquIHy5xl04
	hjG0rFNvODc6vxV+lzd49mFx/6QHSfWK9MMQBcvV+xGzOobk6XSMBwafvsFFB33HhWVj
	h6yoUA1ZGjaGrkIeyFd6PdGJnVuwBwXFU8iCS3y2Mg3pawSGjlMHGhwBTMUUO5WXViHN
	ct2g==
X-Gm-Message-State: APjAAAUc0syr8p0WcKQwBf9/19Qz4Cijnr3YOiEtvR9/u52A9x/P8NN4
	yn4xB0izMoY7NK48AbauhbeFsH5Ej44=
X-Google-Smtp-Source: APXvYqwzh6i+hC6qJiOZ8vdMAvqJbyD5YUyeYCIuZlgexRdpKdqf8PTgw9yWIUkE3UZ79lzW+WEbzQ==
X-Received: by 2002:adf:db89:: with SMTP id u9mr14088239wri.190.1557649687222; 
	Sun, 12 May 2019 01:28:07 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	z74sm17032075wmc.2.2019.05.12.01.28.05
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 12 May 2019 01:28:06 -0700 (PDT)
Message-ID: <850ae48669455c75cf34b2306f01add428aa62c0.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sun, 12 May 2019 09:28:05 +0100
In-Reply-To: <ac4edd962cb6b4831cb85cd731d2d2a810c62503.1557388944.git.liezhi.yang@windriver.com>
References: <cover.1557388944.git.liezhi.yang@windriver.com>
	<ac4edd962cb6b4831cb85cd731d2d2a810c62503.1557388944.git.liezhi.yang@windriver.com>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] bitbake: cookerdata: Avoid double exceptions for bb.fatal()
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
X-List-Received-Date: Sun, 12 May 2019 08:28:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-05-09 at 16:03 +0800, Robert Yang wrote:
> The bb.fatal() raises BBHandledException() which causes double exceptions,
> e.g.:
> 
> Add 'HOSTTOOLS += "hello"' to conf/local.conf:
> $ bitbake -p
> [snip]
> During handling of the above exception, another exception occurred:
> [snip]
> ERROR: The following required tools (as specified by HOSTTOOLS) appear to be unavailable in PATH, please install them in order to proceed:
>   hello
> 
> Use "raise" rather than "raise bb.BBHandledException" to fix the double
> exceptions.
> 
> [YOCTO #13267]
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/cookerdata.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/cookerdata.py
> b/bitbake/lib/bb/cookerdata.py
> index f8ae410..585edc5 100644
> --- a/bitbake/lib/bb/cookerdata.py
> +++ b/bitbake/lib/bb/cookerdata.py
> @@ -301,7 +301,9 @@ class CookerDataBuilder(object):
>              if multiconfig:
>                  bb.event.fire(bb.event.MultiConfigParsed(self.mcdata
> ), self.data)
>  
> -        except (SyntaxError, bb.BBHandledException):
> +        except bb.BBHandledException:
> +            raise
> +        except SyntaxError:
>              raise bb.BBHandledException
>          except bb.data_smart.ExpansionError as e:
>              logger.error(str(e))

Hi Robert,

This doesn't sound right, where is this exception being printed a
second time? The point of "BBHandledException" is to say "don't print
any further traces for this exception". If this fixes the bug, it means
something somewhere is printing a trace for a second time when it
should pass through BBHandledException?

Cheers,

Richard


