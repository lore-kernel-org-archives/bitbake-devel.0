Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
	[209.85.214.195])
	by mail.openembedded.org (Postfix) with ESMTP id EAF4461517
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 15:44:47 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id y8so8212649pll.13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 07:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:autocrypt:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=M+sjp5vuq6QeQ5WUouJC7XPPRnA9Ys+olfU0js3+F9I=;
	b=Pyw+Nm3qHwOnND2VnpuxteLsBELfqGl9oVvEjVkbl7WrVy02BEBUaoOw7msqAxlEFf
	fMK0mJPKIe2miqJk4bAed+MQsVfrRwYOeuwOVHYsDGPUIe5n/6hyfwDrbTzmM4dOnU/5
	UHQeHIcOCwPWN3CXnSrgHdh/DN5BE0O6+CxoLdmPsk1eo1cGbHetlQX5ATHAXniqJoaf
	U5uzmJkaTFsalfTahJzbG4ibR8pg/MpA6x4czfbKquLAX4wUH0baOAuLNCADi10jC9Hb
	2sCjnlnEbPjzu+p1qvbUiYUUvpXTpKPNz7OmpTWRrFODxuir93SV8lpVg5w3afKVZJsW
	mqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=M+sjp5vuq6QeQ5WUouJC7XPPRnA9Ys+olfU0js3+F9I=;
	b=FrFhQ7G2y4Uh9oWEJtq4eMKqyNub3kNVsfMO9fxGFPgsyV22Jla0aRCXbON+0BKfgm
	Emb6pWM5VRciUSrnq3TH9DH+6TpykJIyDGAGsC0DhmxU49bXKbNHGoBdH4VA/X1QhDqM
	pRltzDYTG+N2UI6pSPCGHXBk7AqPU8Sveq8AMzxPn9ARuwTQTOYewSkYT2KHD+svCm5L
	Kvqr3A/gK+woP4pXsEVqXTaq4JR3QV0x9dgXeoe+tTi72SrC3vaR4f3RIuVO07HRkCAG
	qpTwhU/G+guNnoaYtnAM50mYd0oEIMB+CG1fk4yL598XMLCP6iWBV4qSKJ9cOMPvWerQ
	R7bg==
X-Gm-Message-State: APjAAAVIUp04dw5+n70i+4/I3d+tRqg6wikm0SR5xDPZLrTOF0nryNLs
	v+t6qopfJWeI8pgDyLMItEWwVUaJ
X-Google-Smtp-Source: APXvYqzA+iaWRRWD42IsTGOnsG6/C/2Yok+lyyQ3TDGtajcoFFNDolUKBUlOoZ8xLAm/LploebjBZg==
X-Received: by 2002:a17:902:9342:: with SMTP id
	g2mr20685269plp.339.1582040688724; 
	Tue, 18 Feb 2020 07:44:48 -0800 (PST)
Received: from ?IPv6:2601:202:4180:a5c0:103:47a6:6829:8136?
	([2601:202:4180:a5c0:103:47a6:6829:8136])
	by smtp.gmail.com with ESMTPSA id v5sm5217697pgc.11.2020.02.18.07.44.47
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Tue, 18 Feb 2020 07:44:48 -0800 (PST)
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
References: <20200217162307.36082-1-richard.purdie@linuxfoundation.org>
From: akuster808 <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <781da9cf-0229-1d3f-ab03-e064cd27265a@gmail.com>
Date: Tue, 18 Feb 2020 07:44:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
	Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217162307.36082-1-richard.purdie@linuxfoundation.org>
Subject: Re: [PATCH] cooker/siggen: Empty siggen cache during parsing
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
X-List-Received-Date: Tue, 18 Feb 2020 15:44:48 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 2/17/20 8:23 AM, Richard Purdie wrote:
> When parsing recipes its apparent the memory usage of bitbake rises linearly
> with number of recipes parsed. It shouldn't.
This seems back port worthy to 1.44, 1.42

- armin
>
> Using tracemalloc (thanks for the tip Joshua Lock) it was clear that the
> dependency information left behind in siggen was the culprit. Add a new
> method to allow us to drop this information. We don't need it after the recipe
> has been parsed and hashes calculated (at runtime its different but only the
> currently executing task would be in memory).
>
> This should give signficant memory usage improvements for bitbake and that
> in turn should help speed on more constrained systems, as well as when used in
> multiconfig environments.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cooker.py |  3 ++-
>  lib/bb/siggen.py | 11 +++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 1124332186..a05630d52d 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -1940,7 +1940,8 @@ class Parser(multiprocessing.Process):
>                  except IndexError:
>                      break
>                  result = self.parse(*job)
> -
> +                # Clear the siggen cache after parsing to control memory usage, its huge
> +                bb.parse.siggen.postparsing_clean_cache()
>              try:
>                  self.results.put(result, timeout=0.25)
>              except queue.Full:
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index ffd8fcaf36..c2d0c736cf 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -51,6 +51,9 @@ class SignatureGenerator(object):
>      def finalise(self, fn, d, varient):
>          return
>  
> +    def postparsing_clean_cache(self):
> +        return
> +
>      def get_unihash(self, tid):
>          return self.taskhash[tid]
>  
> @@ -188,6 +191,14 @@ class SignatureGeneratorBasic(SignatureGenerator):
>          for task in taskdeps:
>              d.setVar("BB_BASEHASH_task-%s" % task, self.basehash[fn + ":" + task])
>  
> +    def postparsing_clean_cache(self):
> +        #
> +        # After parsing we can remove some things from memory to reduce our memory footprint
> +        #
> +        self.gendeps = {}
> +        self.lookupcache = {}
> +        self.taskdeps = {}
> +
>      def rundep_check(self, fn, recipename, task, dep, depname, dataCache):
>          # Return True if we should keep the dependency, False to drop it
>          # We only manipulate the dependencies for packages not in the whitelist


