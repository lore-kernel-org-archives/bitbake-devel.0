Return-Path: <twoerner@gmail.com>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
	[209.85.213.173])
	by mail.openembedded.org (Postfix) with ESMTP id 0262B75886
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jun 2015 15:18:06 +0000 (UTC)
Received: by igbzc4 with SMTP id zc4so105598602igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jun 2015 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=PmCm9qPYXAePs4kH9PehKpvPcIiiD9kLf3h9nEt8HUw=;
	b=c/+VCRh3Q0klS5HSD3ReS8h+jMmXVPY3LdRv3QmZsBcAMZNv2aon2M0MZ5LsvA5u3j
	v7R8LnTlsAQvJiOz6e1MlKFECWzQuQjsGoyEkSC3SRdDrlFG2WGZKEP2MN1aepcoYPM9
	5M+wFqKLzuyd/qZpAyFjeL2Iot4iokoSp8756Rdpve2+HJeV6jzC/qbvVFeVsTRYQzYc
	FlWLiNgQfLllc8sysMjNxapJUnnuIYerno91v+lvBuzYX0kaKgchvBxugf3yFbQkZRmy
	COfftC8tgX9Io5jY7Z4wV7I6y3ZqQYQmeocJy0wDbm24bVBh6lOYlMqSRJcb7y2sC6qN
	ZAzg==
X-Received: by 10.50.59.180 with SMTP id a20mr35818925igr.23.1434554286038;
	Wed, 17 Jun 2015 08:18:06 -0700 (PDT)
Received: from [192.168.141.83] (dsl-67-55-28-109.acanac.net. [67.55.28.109])
	by mx.google.com with ESMTPSA id
	d4sm2775336iod.17.2015.06.17.08.18.05
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 17 Jun 2015 08:18:05 -0700 (PDT)
Message-ID: <55818FB3.6080003@gmail.com>
Date: Wed, 17 Jun 2015 11:18:11 -0400
From: Trevor Woerner <twoerner@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1432923403-31440-1-git-send-email-twoerner@gmail.com>
In-Reply-To: <1432923403-31440-1-git-send-email-twoerner@gmail.com>
Subject: Re: [PATCH] bitbake-user-manual: add BBLAYERS_FETCH_DIR
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
X-List-Received-Date: Wed, 17 Jun 2015 15:18:07 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

ping?

On 15-05-29 02:16 PM, Trevor Woerner wrote:
> Add BBLAYERS_FETCH_DIR to the Variables Glossary.
>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   .../bitbake-user-manual-ref-variables.xml                   | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
> index 86bf30b..bdbf421 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.xml
> @@ -1016,6 +1016,19 @@
>               </glossdef>
>           </glossentry>
>   
> +        <glossentry id='var-BBLAYERS_FETCH_DIR'><glossterm>BBLAYERS_FETCH_DIR</glossterm>
> +            <glossdef>
> +                <para>
> +                    Sets the base location where the layers are stored. By
> +                    default this is set to <filename>${COREBASE}</filename>.
> +                    This is used in conjunction with <filename>bitbake-layers
> +                    layerindex-fetch</filename> and tells
> +                    <filename>bitbake-layers</filename> where to place the
> +                    fetched layer(s).
> +                </para>
> +            </glossdef>
> +        </glossentry>
> +
>           <glossentry id='var-BBMASK'><glossterm>BBMASK</glossterm>
>               <glossdef>
>                   <para>


