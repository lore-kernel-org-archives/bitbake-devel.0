Received: from mail-pa0-f47.google.com ([209.85.220.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <otavio.salvador@gmail.com>)
	id 1Tbz4h-0000f9-Jo; Fri, 23 Nov 2012 20:38:07 +0100
Received: by mail-pa0-f47.google.com with SMTP id fa10so1441039pad.6
	for <multiple recipients>; Fri, 23 Nov 2012 11:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date
	:x-google-sender-auth:message-id:subject:from:to:cc:content-type;
	bh=Uoq/c5WUW5o8BUPdyEWSxpTjx2aiaOBtn326sMP+nOI=;
	b=X9Dc5Jlv5YrjYuzq5RzhW+JC26ejrRJwXyNemTTgmiYmYJVmUjrALIr1CQbhErArDQ
	oXboqEIA5/D5GYzNrcaBwA2H7Uw1LHwFgi3Xv4Awej6pH13NkLjQ/civ4S45YCsE3W21
	E2Z14/pzIyalqp95rJpBAR1uLTL3wF/C+ZtweDjARuiurPNaaB5G8QSFwUAZgIjFdw1m
	Hh39Et3MJ0SXdmYp9XoRgGKhEjp/XOJL1xnvrMgaOuh8XpGUT+l8HKZrMYOiJ7e55anq
	DfR3j+pL7UzgPAJZmKqMIWfPMjiCQx71FsNHw+XGvuRr3cEIj234U4Ih5nHBFdb6GIP6
	dzMg==
MIME-Version: 1.0
Received: by 10.68.204.103 with SMTP id kx7mr16827740pbc.33.1353698638667;
	Fri, 23 Nov 2012 11:23:58 -0800 (PST)
Sender: otavio.salvador@gmail.com
Received: by 10.68.16.225 with HTTP; Fri, 23 Nov 2012 11:23:58 -0800 (PST)
In-Reply-To: <1353691611.1361.28.camel@ted>
References: <1353691611.1361.28.camel@ted>
Date: Fri, 23 Nov 2012 17:23:58 -0200
X-Google-Sender-Auth: Pt4yLkN30yOvFB37eh-cKEmYV0o
Message-ID: <CAP9ODKqPx8AE9O66ALLkpwXDFxr1outs_tdeDG2DnyZdw9Q=Ag@mail.gmail.com>
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
X-List-Received-Date: Fri, 23 Nov 2012 19:38:07 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Nov 23, 2012 at 3:26 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> Currently we have some rather complex and potentially broken code in the
> fetcher code to deal with the the fact that you don't get incremental
> versions from git revisions easily. The system currently has a database
> and generates incremental numbers so PV becomes something like:
>
> 0.1+git1-deadbeefdecafbad
>
> or for perverse recipes with more than one git source:
>
> 0.1+git1-deadbeefdecafbad-git3-decafbaddeadbeef
>
> We currently have a bug that this doesn't interact well with sstate
> feeds since you have to have a single persistdb for any given sstate
> feed. It won't break in that sstate will just not be used but that is
> inefficient.
>
> The fact we need to have increasing values in the field is a very
> similar problem to the incremental PR for package fields that we're
> addressing with the PR server.

Yes; I had problem using GIT with PR server last time I tried it.

Good that it's being worked on/has been fixed.

> I've therefore taken a step back and considered things and am proposing
> that we adapt the PR server to handle this issue and then drop the code
> from the fetcher. The rough implementation of this would mean that:
>
> * PV would become 0.1+gitAUTOINC-deadbeefdecafbad-decafbaddeadbeef
>
> * We'd have one incrementing value rather than several.
>
> * That the code would detect a PV containing AUTOINC and set PKGV to the
> same thing with AUTOINC replaced with the "auto PR" value
>
> * We'd do this in parallel with the usual auto PR value. In PR server
> terms this means likely in the same data table using "git-PV" as the key
> and just call the API with a different key name.
>
> * If the PR server isn't running, this would just set PKGV to PV but
> with AUTOINC set to 0. This would mean you wouldn't get updating package
> feeds but usual image creation would be just fine.
>
> * There are some complexities for data import and export we need to
> consider and work through.
>
> All things considered I think this would be a nice improvement and allow
> us to have one good set of "incremental" code and simplify the fetchers.
>
> I'm open to discussion... :)

I like to idea of a single updating place. What I dislike is AUTOINC
not being taken care in the fetcher.

In this case any GIT revision changes, the AUTOINC won't bump as usual
(without PR server)?

-- 
Otavio Salvador                             O.S. Systems
E-mail: otavio@ossystems.com.br  http://www.ossystems.com.br
Mobile: +55 53 9981-7854              http://projetos.ossystems.com.br


