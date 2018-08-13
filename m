Return-Path: <akuster808@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
	[209.85.218.68])
	by mail.openembedded.org (Postfix) with ESMTP id 5FD7578F5C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 18:20:59 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so28966899oib.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=SxLqMwe/3wCMbyy1O4fM+WsbmGFvedX8nWtyMfuv/BE=;
	b=iDNS/rb98/fI5fOcRzNCRO18tchPODIgsfJ8w+5wtz0dRyxD5FTFsv13jtHgfWfSyd
	3Tm74PvhOWEk5W9IGCPd2bp4wgwVDDIvUT+9BH0gK+GZPYSayeVjH8gQMJZoQbGJbgD5
	+aZBdrdJMsf2Y3DayoG26xJDs85hoCTeZr+7JDl2EI95qnUNiR8fCGa3B54cjIQn+wpS
	RkvnU7e2CdgveC3L8K5zZHe/+gphqWfnGC1wm6Js037pRn47eXn8YaseLW3L4xOVxUoM
	cwrhRgQEPH7O3MhVMSh6aeiTQhsW+89zSn1rnXlfjvWevdlXB39y9T9M8sXswNnlVrBO
	Qq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=SxLqMwe/3wCMbyy1O4fM+WsbmGFvedX8nWtyMfuv/BE=;
	b=tT8u/AF8qptgynRkdPHGpytJjbgaoUL7CTZm1NexOErvBAnTvacQLbmgmL1AJf90sU
	1jW8POx+LZC9qh49ZgSYvFAd6goCgGUFECIIkrWdAokRYDCfMvE4K5S42P3RaSZInyI5
	m0OTh7zbhchhBc5vqsyA0lJpMrnZZvau/nWd6ae3bCTCSXF2q6jO8ig05YKDX/Pc8w1M
	D2Fa3ksD6wwQHWbHClgITwcQznuyzAFGPJlXZbtAKlDohGXSwwxIHmkyxUwqYk44JdFU
	VnbTw/tBt+KGbh/QxIWvbuVSn1caTNG0WKZKQ9M/oNTyGQ9kyT0X1NcmfHylHFo17iO5
	rJoA==
X-Gm-Message-State: AOUpUlHySoCbmbJdNDCPxJ4bity35JJez8GA4gpYUkwZ6ZIcXhf26HfU
	zmin/l+I/UqHqXb3wue0HDoPZqpl
X-Google-Smtp-Source: AA+uWPzFTBP2e0EjMnNK3GwMbIc8zFgkfuIzAxjAU0yBONTummkjqzXWR0tmJMqZu4itFUgepkdfTQ==
X-Received: by 2002:aca:ed57:: with SMTP id
	l84-v6mr20418854oih.62.1534184460089; 
	Mon, 13 Aug 2018 11:21:00 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:64f0:5919:ccc1:f72d?
	([2601:202:4180:c33:64f0:5919:ccc1:f72d])
	by smtp.gmail.com with ESMTPSA id
	s142-v6sm12634425oie.48.2018.08.13.11.20.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 Aug 2018 11:20:59 -0700 (PDT)
To: Ross Burton <ross.burton@intel.com>, bitbake-devel@lists.openembedded.org
References: <20180813180226.18299-1-ross.burton@intel.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <8919df06-fa05-f464-f346-734b7cfc8546@gmail.com>
Date: Mon, 13 Aug 2018 11:20:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813180226.18299-1-ross.burton@intel.com>
Subject: Re: [PATCH 1/2] utils/md5_file: don't iterate line-by-line
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
X-List-Received-Date: Mon, 13 Aug 2018 18:20:59 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 08/13/2018 11:02 AM, Ross Burton wrote:
> Opening a file in binary mode and iterating it seems like the simple solution
> but will still break on newlines, which for binary files isn't really useful as
> the size of the chunks could be huge or tiny.
>
> Instead, let's be a bit more clever: we'll be MD5ing lots of files, but we don't
> want to fill up memory: use mmap() to open the file and read the file in 8k
> blocks.
>
> Signed-off-by: Ross Burton <ross.burton@intel.com>
> ---
>  bitbake/lib/bb/utils.py | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index 9903183213b..b20cdabcf01 100644
> --- a/bitbake/lib/bb/utils.py
> +++ b/bitbake/lib/bb/utils.py
> @@ -524,12 +524,17 @@ def md5_file(filename):
>      """
>      Return the hex string representation of the MD5 checksum of filename.
>      """
> -    import hashlib
> -    m = hashlib.md5()
> +    import hashlib, mmap
>  
>      with open(filename, "rb") as f:
> -        for line in f:
> -            m.update(line)
> +        m = hashlib.md5()
> +        try:
> +            with mmap.mmap(f.fileno(), 0, access=mmap.ACCESS_READ) as mm:
> +                for chunk in iter(lambda: mm.read(8192), b''):
> +                    m.update(chunk)
> +        except ValueError:
> +            # You can't mmap() an empty file so silence this exception
> +            pass
>      return m.hexdigest()
>  
>  def sha256_file(filename):
Fixes the problem I was having. thanks

Acked-by: Armin Kuster <akuster808@gmail.com>


