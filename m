Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
 by mx.groups.io with SMTP id smtpd.web11.27024.1586122882079621423
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 05 Apr 2020 14:41:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Rpbu15qy;
 spf=pass (domain: gmail.com, ip: 209.85.221.196, mailfrom: armccurdy@gmail.com)
Received: by mail-vk1-f196.google.com with SMTP id s194so3458649vkb.11
        for <bitbake-devel@lists.openembedded.org>; Sun, 05 Apr 2020 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QH8QVSvee6y0/rwgloJ0kJgvWWQ0ATGzGsNRwW5ZzMI=;
        b=Rpbu15qyeOdPa4qCWxFFGg9NhCCduedfuMcKluJJ5X+8NVdbtF9f/sHQHcDS56E8UL
         WYN+f4j6gnEaQCr0YwgbFIuzvmQPBOfVdjPdS2nR9keuQpCBxpCBQvB6oxtfnuysxjwR
         pAAaxbb+ciKiYsY8FpJ409mX0R3fJG1vMOOaE3oGLZ8yf5JTdUmhcrl9beUVNwq20IyX
         gQzUFBcAp/BX9mw4DhqxSggEmpYP1MjMABDCD43vd5ewt+mvXzwu7KK1j7QyZh96nfr5
         K+xcJmMPfMPsR+mnpHOuYSAUDAJDDTH7VgqdQDnwtQETIzRhbPsX+UhmlbFLEPKQIT21
         3JAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QH8QVSvee6y0/rwgloJ0kJgvWWQ0ATGzGsNRwW5ZzMI=;
        b=pjsJql/EZirTrOmtc6PIxr5rptx+A+mQbcl6eEFg8akDmjj+MlxjKCXwf2ji+XBQz+
         s++AbqWM8u/X2acvMs4LUGncNTsXej5rsKretOTmfT8fw8cPPLxzXdQS2shm9jK8E70/
         eZeo2JlxJXU2asPqmqVQ93ArXab1ngH9HiYEJJI/ZJPE68WaLjfyfd42svKSU1HpPcMT
         VF/eHrGzCR/RtX6f/uCRN6UQdezveJipVMc3zPncuFJtPVRGSCfyKYz4O201pQY3rKW9
         jlIt9RlUpvL35hbNFJn+MNzvyuc+fqBvCqQN9OqkfE+Cu7ru6scMydd+iMPgXjtnZeT8
         K6Ow==
X-Gm-Message-State: AGi0PuZuRDt9WPCHosj2LiLU8GmMdzEXB3oEjC1+2MahIRqKIBzacW/f
	zLWFXUSHlbXyjMw7W1/OJmz+2LRrpE9Rww1VY5E=
X-Google-Smtp-Source: APiQypKrvbUL0tDnw6RQ+BMPtPI1n4dTW1oLQCcmaAMKXy28sFXnoamDh4/5DimhtQm4q+zl0k68Ws552WdtNGvP86s=
X-Received: by 2002:a1f:a055:: with SMTP id j82mr12615301vke.75.1586122881049;
 Sun, 05 Apr 2020 14:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200402195104.2405-1-bernd.bauer@gmx.at> <fb960c2f15390746d24fd95368478c518748c957.camel@linuxfoundation.org>
 <55c322d4-aa7a-4a6e-6fbe-70ab9eecee83@gmx.at>
In-Reply-To: <55c322d4-aa7a-4a6e-6fbe-70ab9eecee83@gmx.at>
From: "Andre McCurdy" <armccurdy@gmail.com>
Date: Sun, 5 Apr 2020 14:41:13 -0700
Message-ID: <CAJ86T=Wgue4EdLZAergwV6-Zg3w-5c33sXvjnC8LCNbx=dm08Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Gitsm does not use credentials when cloning submodules
To: bernd.bauer@gmx.at
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 3, 2020 at 12:29 AM Bernd Bauer <bernd.bauer@gmx.at> wrote:
> Am 02.04.20 um 23:08 schrieb Richard Purdie:
> > On Thu, 2020-04-02 at 21:51 +0200, Bernd Bauer wrote:
> >> If the git server needs authentication the credentials are
> >> encoded in the URL of the repositories.
> >> The credentials from the main repository are deposited in the
> >> recipe so main repository can still be cloned.
> >>
> >> But the URLs from the submodules are listed in the .gitmodules
> >> file.
> >> The submodule url is encoded with an username and a password
> >> or a bitbucket URL token. See example.
> >>
> >> The password is not stored in the ud.user but in the ud.pswd
> >> variable. So in this case the url is made up by ud.user and
> >> ud.pswd.
> >>
> >> Example:
> >> [submodule "sub1"]
> >>         path = sub1
> >>         url = https://user:password@test.org/url/to/sub1
> >>
> >> Signed-off-by: Bernd Bauer <bernd.bauer@gmx.at>
> >> ---
> >>  bitbake/lib/bb/fetch2/git.py | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > We have had requests for this before and we've said "no" since
> > encouraging people to put passwords in urls is bad and it leads to
> > people making accidental exposures. Its basically too risky.
> >
> > For git submodules the line becomes blurred.
> >
> > I'm open to the opinions of others but in this form the patch applies
> > to git and gitsm and that in itself makes it more risky.
> >
> > I do understand why people want this, equally it really isn't a great
> > idea in general :/.
> >
> > Cheers,
> >
> > Richard
>
> Hi!
>
> Of course it is not a good idea to write the credentials directly
> in the recipe or in the .gitmodules.
> Unfortunately I have no other choice than to encode the username
> and password in the URL. This GIT server only allows HTTPS with
> authentication. No SSH keys, no anonymous checkout.

Google brings up a few possible alternatives:

  https://confluence.atlassian.com/bitbucketserver/permanently-authenticating-with-git-repositories-776639846.html

I also need to access a git server which supports only https with
authentication and .netrc has always worked fine for me.

> But without my patch the result would be the same.
> I would have the URL with username and password in the
> recipe and also in the submodules.
> The only difference would be that I would have to define a
> task in the recipe to check out the submodules.
> So my recipe is getting complexer.
>
> do_configure_prepend() {
>   cd ${WORKDIR}/git
>   git submodules update --init --recursive
> }
>
> From my point of view, my patch would be more like
> fixing a bug than an extension.
>
> Just my two cents...
>
> Greets Bernd
> 
