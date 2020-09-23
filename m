Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.528.1600891972035938385
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2020 13:12:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=X0ixamOf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f67.google.com with SMTP id w5so1347255wrp.8
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2020 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=cA5C2GQbycdlKimgUlBSkvYIxus9ytVWCJUxVgRSGd4=;
        b=X0ixamOf9ncDdu4r6UalmCl4phqmDuSpjlrgUIiXQ8isbQuxfeb3THOoggi8Nveysd
         FXNbxsh7QA4j3p7fIF1/ngip1DPe8hnUIjyczJxjGBalFjLOFgJKip7G/yjNlbx3s0GM
         R8olkJbTRv3NZDNwekXfPji+UQ6NNnBOVaeqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cA5C2GQbycdlKimgUlBSkvYIxus9ytVWCJUxVgRSGd4=;
        b=boopeg+xpwATDRHM66KrOa78LZh5SoJ2irAZqkdd1XH+mqV+yZTkN7SxUQ3V8aX2Tp
         HC9e5bdpUCjJ1u6qVP2P9ofhdt96p1NZdmXTdjW46U+EOU3nt6q3UeJ+NRgchRK2dMQt
         qEtUTDe8n/geU2kOlN8fzIXSxEa2vImL9K4KfwlTxPgkAtaNcjkDCNxte3KVQ6D2IvY+
         gbI2JT6myu5ansEh6yeb485Cc5Ux8Hhu9hc3fqd3hwnSY9NWpugilSqqd6KLbEfCT2Ip
         ELSZjRfdut+6EaloOoEf9K8s31bZBEfhnJQD8uFiSBCKxi6gduh9LrqIWyk6BfWfGovw
         JAWA==
X-Gm-Message-State: AOAM530QD/r2gl/zlgBjrOfT0zLgiHnDApJZT3/EmJqe7oTfIXOkYGsV
	MIAuRR2Lb7cLx4wuoAma1OdDsA==
X-Google-Smtp-Source: ABdhPJys6p9vslv0wUZ/0L9JorSyb2Lo87iSLEAhjMkC7CnKnt5FQjlxqudVjJUmFPMmjgXvOVaYiQ==
X-Received: by 2002:adf:90a2:: with SMTP id i31mr1513116wri.276.1600891970372;
        Wed, 23 Sep 2020 13:12:50 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 6.1.9.3.6.2.6.e.a.a.c.2.3.5.1.b.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (6.1.9.3.6.2.6.e.a.a.c.2.3.5.1.b.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:b153:2caa:e626:3916])
        by smtp.gmail.com with ESMTPSA id z15sm881699wrv.94.2020.09.23.13.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:12:49 -0700 (PDT)
Message-ID: <2136b54036d7b0bab520e203aae5e3438762e46f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 2/2] tests/fetch: backslash support in file:// URIs
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Leif Middelschulte <leif.middelschulte@klsmartin.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 23 Sep 2020 21:12:45 +0100
In-Reply-To: <20200923161832.235619-2-leif.middelschulte@klsmartin.com>
References: 
	<ed36fb9b7d921afaeee3f83e84d2a521e028dc09.camel@linuxfoundation.org>
	 <20200923161832.235619-2-leif.middelschulte@klsmartin.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-09-23 at 18:18 +0200, Leif Middelschulte wrote:
> Implements backslashes in local filenames.
> A typical usecase for such a filename is a systemd unit.
> 
> Example: `dev-disk-by\x2dpath-foo.device`
> ---
>  lib/bb/tests/fetch.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 0ecf044f..c392afc9 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -584,6 +584,7 @@ class FetcherLocalTest(FetcherTest):
>          touch(os.path.join(self.localsrcdir, 'dir', 'd'))
>          os.makedirs(os.path.join(self.localsrcdir, 'dir', 'subdir'))
>          touch(os.path.join(self.localsrcdir, 'dir', 'subdir', 'e'))
> +        touch(os.path.join(self.localsrcdir, 'backslash\x2dsystemd-unit.device'))
>          self.d.setVar("FILESPATH", self.localsrcdir)
>  
>      def fetchUnpack(self, uris):
> @@ -601,6 +602,10 @@ class FetcherLocalTest(FetcherTest):
>          tree = self.fetchUnpack(['file://a', 'file://dir/c'])
>          self.assertEqual(tree, ['a', 'dir/c'])
>  
> +    def test_local_backslash(self):
> +        tree = self.fetchUnpack(['file://backslash\\x2dsystemd-unit.device'])
> +        self.assertEqual(tree, ['backslash\\x2dsystemd-unit.device'])
> +
>      def test_local_wildcard(self):
>          with self.assertRaises(bb.fetch2.ParameterError):
>              tree = self.fetchUnpack(['file://a', 'file://dir/*'])

Thanks for this, looks good. Unfortunately something doesn't seem quite
right as the tests fail:

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/1395/steps/8/logs/step1d

?

Cheers,

Richard

