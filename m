Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id 0AE937FCD0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2019 16:26:52 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id g206so7807932wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2019 08:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=XaA0REYNHzaomHaZ+6NnuPRSx1rHF3PI/2qcSuJqodI=;
	b=Kp03xPh8lMXVFPHMFXP5JVAah1JY5OCVI+GAc/3wMrecaYTMOjVxD2liIhKPoDR/A/
	opxzFs7XI1gB8/DboUKazB4FRL304VAGvCEw3EgtuM9vtJ2J0s3muX6kwscQAoMwKUFr
	YiAvnSvRpZblSwFrMFlVg5ZleoNcAtKsAsuvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=XaA0REYNHzaomHaZ+6NnuPRSx1rHF3PI/2qcSuJqodI=;
	b=ggMQbeM/In49bHIk0rdo6BFG8IJXqhcIt35ChNA0WUjlNB1S8x9NmL8DbITIrwF63M
	865gQLRiuVTVTUb0DfOzZsP0A8cFsPhYPH2WdE8pqzUBQiFfhEbnatPKSXjWG7/ckVeM
	F3sGMwkLZQvNKcWB0PH6nP4lkuUCjYPeYv+85XeJ4vNW6kiEa215jKBSYAsSHUvNBW3Q
	DQUpxtp4c3DU6Ha5/4YAs5aFzOcmt15SVM0+HjeZ1f/OHqL45xEde4jG3uLpZciZUz84
	l/biM00lU5wF9G9iuY/pXjNnj74zQxiaNuRrGAPNCYnw5uSQ2AA8WnW4MBrPaHyd4dQM
	ZBWg==
X-Gm-Message-State: APjAAAVGjke0MubelnveBvUHUqFyGIqCnBfqq2vVzBkmiwsQ9g2COG42
	+2lmka9PiCmTmYazcj2FsOFTHkDd2kg=
X-Google-Smtp-Source: APXvYqz2STCEnluykKbdtLcM2sxS/cUh8i4f1Rpy2APNXAjlmNOnJSxpr0mV7szDN8QJfP6AdgXqtA==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr18156299wmj.127.1574440013629;
	Fri, 22 Nov 2019 08:26:53 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id z2sm8392232wrs.89.2019.11.22.08.26.52
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 22 Nov 2019 08:26:53 -0800 (PST)
Message-ID: <9e4cd37857c305b4c14431df339fc6be6cbf5b98.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 22 Nov 2019 16:26:51 +0000
In-Reply-To: <20191120093412.11519-2-jean-marie.lemetayer@savoirfairelinux.com>
References: <20191120093412.11519-1-jean-marie.lemetayer@savoirfairelinux.com>
	<20191120093412.11519-2-jean-marie.lemetayer@savoirfairelinux.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Cc: rennes@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: Re: [PATCH v3 1/7] bitbake: utils.py: add sha384_file and sha512_file functions
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
X-List-Received-Date: Fri, 22 Nov 2019 16:26:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-11-20 at 10:34 +0100, Jean-Marie LEMETAYER wrote:
> This commit adds the "sha384_file" and "sha512_file" functions in
> order
> to check the integrity of the downloaded npm packages as npm now use
> subresource integrity:
> 
>   https://w3c.github.io/webappsec-subresource-integrity
> 
> Signed-off-by: Jean-Marie LEMETAYER <
> jean-marie.lemetayer@savoirfairelinux.com>
> ---
>  lib/bb/utils.py | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index d035949b..34152855 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -562,6 +562,30 @@ def sha1_file(filename):
>              s.update(line)
>      return s.hexdigest()
>  
> +def sha384_file(filename):
> +    """
> +    Return the hex string representation of the SHA384 checksum of
> the filename
> +    """
> +    import hashlib
> +
> +    s = hashlib.sha384()
> +    with open(filename, "rb") as f:
> +        for line in f:
> +            s.update(line)
> +    return s.hexdigest()
> +
> +def sha512_file(filename):
> +    """
> +    Return the hex string representation of the SHA512 checksum of
> the filename
> +    """
> +    import hashlib
> +
> +    s = hashlib.sha512()
> +    with open(filename, "rb") as f:
> +        for line in f:
> +            s.update(line)
> +    return s.hexdigest()
> +
>  def preserved_envvars_exported():

Note that:
http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=9d2fd91844fe387186b780b5457d0c02bea998e7 
merged, so this patch probably needs tweaking to match, thanks.

Cheers,

Richard


