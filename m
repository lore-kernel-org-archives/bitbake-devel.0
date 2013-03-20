Received: from mail-oa0-f49.google.com ([209.85.219.49])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <otavio.salvador@gmail.com>) id 1UINXq-0002Lt-KS
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Mar 2013 19:15:28 +0100
Received: by mail-oa0-f49.google.com with SMTP id j6so2082871oag.8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Mar 2013 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:sender:in-reply-to:references:date
	:x-google-sender-auth:message-id:subject:from:to:cc:content-type;
	bh=ZwLUUQZiUlD7O2FTxvfGrNC5iYfgZSshOdACN13c2Sw=;
	b=EPicN1uk2eW8XrR4m1uQiH2fBnq+oMBkrbJVfxz6cdNFSVxFDkRVxchvhglwfYITWv
	UMp6dHxlmYWdBXP5hJpq5836a+KirrPr2H0Uxj1op/xTP7CKlMfJXjde6bv53NUgcwIk
	FDbZwpRaVZ8nNm2VgygMTgDn+G3LTMkJR0qldO6jaUeEhMe0XE0+tcTlpC1hmuE8C87J
	5EQqboUs3daiKTNDAmY9LKGKVnE8DSc9gifX5X+c88HCSdox/qhnrMY7aSnsXLWaBpnX
	DR+fAhgLj4ggAeHZmU1i+D/IYoRRrJOETEfu3r9V635egvCCFHbYptGUTmSxdGa+nuXp
	LeGQ==
MIME-Version: 1.0
X-Received: by 10.60.171.102 with SMTP id at6mr4916450oec.60.1363802314936;
	Wed, 20 Mar 2013 10:58:34 -0700 (PDT)
Sender: otavio.salvador@gmail.com
Received: by 10.182.80.198 with HTTP; Wed, 20 Mar 2013 10:58:34 -0700 (PDT)
In-Reply-To: <1363802396-12282-1-git-send-email-otavio@ossystems.com.br>
References: <1363802396-12282-1-git-send-email-otavio@ossystems.com.br>
Date: Wed, 20 Mar 2013 14:58:34 -0300
X-Google-Sender-Auth: A6IHCuF0BBKm9ce-4TC4tHBKVec
Message-ID: <CAP9ODKo1hd-kKVS=Du7upok-+=1up2NNbGbfqJ=Kai669=dPKA@mail.gmail.com>
From: Otavio Salvador <otavio@ossystems.com.br>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH] data_smart.py: Rename variable flags
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 20 Mar 2013 18:15:28 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Mar 20, 2013 at 2:59 PM, Otavio Salvador
<otavio@ossystems.com.br> wrote:
> The variable expansion needs to handle variable flags as well
> otherwise those do not behave as expected. One example of this is:
>
> ,----
> | ALTERNATIVE_TARGET_${PN}-foo[name] = "value"
> `----
>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

I think this does not work for all cases but I don't know how to deal
properly with it. It fixes the case of updates-alternative but breaks
other code.

--
Otavio Salvador                             O.S. Systems
E-mail: otavio@ossystems.com.br  http://www.ossystems.com.br
Mobile: +55 53 9981-7854              http://projetos.ossystems.com.br


