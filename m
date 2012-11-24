Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <otavio.salvador@gmail.com>)
	id 1TcGQ2-00069k-K2; Sat, 24 Nov 2012 15:09:18 +0100
Received: by mail-pb0-f47.google.com with SMTP id un1so4950572pbc.6
	for <multiple recipients>; Sat, 24 Nov 2012 05:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date
	:x-google-sender-auth:message-id:subject:from:to:cc:content-type;
	bh=vRaNOobLoIfH53GznCvImrbPV7oSnhd5olu4jfWi1I0=;
	b=MvMfsUb9PDdQfe4rTlrQQ3ejePH3o3eJRwRfoJONjbZr6/c7Hy+vfoUu03gj++AL6M
	C6fG7PBo+LZaxmgpGts50vnxgn06TXgGCbyXd9D4wUxinwk4hBUbH12bpAGiRwH4RyFO
	5AyRA6rjfjmht/XonGEz8u9kfcazjFi7iTYNp9B2FSCf9a+ErWSBfse5VxZWRVglzbvz
	HHsEYIufiL5MOPOp/eoagiwG+iNdlFuCHglSLLltYU/ofnSZV4nhf4JAIA8RgVtE0whS
	lDPa0qD25pSUUUzVlZI6Y3Q62lGIy3aSv8pjiXvBzGarC4lTXUfh5i7O2zfzK/ZaDJaF
	htCQ==
MIME-Version: 1.0
Received: by 10.66.90.101 with SMTP id bv5mr18336681pab.42.1353765308588; Sat,
	24 Nov 2012 05:55:08 -0800 (PST)
Sender: otavio.salvador@gmail.com
Received: by 10.68.16.225 with HTTP; Sat, 24 Nov 2012 05:55:08 -0800 (PST)
In-Reply-To: <1353699909.7352.2.camel@ted>
References: <1353691611.1361.28.camel@ted>
	<CAP9ODKqPx8AE9O66ALLkpwXDFxr1outs_tdeDG2DnyZdw9Q=Ag@mail.gmail.com>
	<1353699909.7352.2.camel@ted>
Date: Sat, 24 Nov 2012 11:55:08 -0200
X-Google-Sender-Auth: ae-EDPbL4NoqPguhrwSL3DEUqsI
Message-ID: <CAP9ODKqQnj4ot2kF7FPYj2QxtT+hr5QTaD_UJhVQM6cSLP3cfg@mail.gmail.com>
From: Otavio Salvador <otavio@ossystems.com.br>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Constantin Musca <constantinx.musca@intel.com>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] RFC: Versioning of git recipes (and incremental PR)
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
X-List-Received-Date: Sat, 24 Nov 2012 14:09:18 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Nov 23, 2012 at 5:45 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Fri, 2012-11-23 at 17:23 -0200, Otavio Salvador wrote:
>> I like to idea of a single updating place. What I dislike is AUTOINC
>> not being taken care in the fetcher.
>>
>> In this case any GIT revision changes, the AUTOINC won't bump as usual
>> (without PR server)?
>
> Why do you need AUTOINC to bump? The only reason we have increments in
> the fetcher is for package upgrading...

Yes but in this case the fetcher won't change AUTOINC and you'll have
same revision even when changing SRCREVs. This will break the upgrade
path for people not using PR server, no?

-- 
Otavio Salvador                             O.S. Systems
E-mail: otavio@ossystems.com.br  http://www.ossystems.com.br
Mobile: +55 53 9981-7854              http://projetos.ossystems.com.br


