Return-Path: <raj.khem@gmail.com>
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
	[209.85.222.193])
	by mail.openembedded.org (Postfix) with ESMTP id 6DBA76C0EE
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 19 Jan 2019 06:45:12 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id m17so1887587qki.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 22:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=VquW5wNvV66QiN6RDHA+9clA4W07E6xuF3hDRN4qpog=;
	b=u0XQ5/HNxJLg6al0DWSKUzEpP89r2tsp0DEqcxxKW/weY6TGC9dmU3+MEppg+axiHE
	d2n5rLH5DQHvad9D4bNzBSSD3+kwydlRR96V3fMJHz+F4ngjgcduWgw3A89f6xQ8qi82
	pmcN/4VYQBXi1oGEfBGWwhCHqo636R44a2147cHdgnGt3G8K0t277YpWTN3jNUSGgezt
	XW0S1yWzbep4Rc6PJf5242SSpqs3rJg8Kzxmpre1WhGx8AUkN5kO7bUapbZj/Tq0mLm9
	lJ9eOGVvT1JlviKX5wTDx/Kx7J+Qm1YR03QQzLf50EF2kETfUacoyLBglUSJh/sIQt2o
	jRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=VquW5wNvV66QiN6RDHA+9clA4W07E6xuF3hDRN4qpog=;
	b=cCOgKdYBmz4WD4jCNamVxAICwiNRHbCFh7N1jo7MX9Mpnp5YrD4bLd0q529nl3lLIN
	Z8uUm3nXtgfG3f/P4YqddNiU6b8HX/R8vKnZUo9r4H8bP7vkLGYH8DmwL7lAwVl5KeJj
	uTXEHEBgCcyTvjSxGbFkINL3v1QQIzhrwWol+bct+7rwRGLXXAlp4uUK4Lr4YOass61N
	kfTR87CIEMLyxcK3h79bypjQslMk+D2O5dZOCUmvCpNe2nBXEUxr7udeIgTto4XDp16F
	uWqquIsWsmF1eigq0TsYPgaVJdNp9pz02Z4PfwrCnCshgSmW4ZMudipd2r1BK9Ma1sc0
	sdWg==
X-Gm-Message-State: AJcUukdpcEYNXyTzg+JOLZBd9XOX62QkCZGXgjK+snhkuzQ4itjsdTEd
	Twzubh3Hh3KkG+ZTlwSwK34LytBxsL73WA45esWITI/a2aA=
X-Google-Smtp-Source: ALg8bN6ZUSKe4JEO97PBVAO40mChtAj6jqEWC52dF0ntZv1YdtKEj53TZ7xwf4zR0dowxBmQf7LHn9N/oFL7/CQpSsw=
X-Received: by 2002:a37:4c41:: with SMTP id z62mr17488622qka.206.1547880312806;
	Fri, 18 Jan 2019 22:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20190115213137.113956-1-mark.hatle@windriver.com>
	<20190115213137.113956-2-mark.hatle@windriver.com>
	<CAMKF1srg335yq2xUtiLxvGkXMQPsTga-4UepQzFD0dem3RTrKw@mail.gmail.com>
	<ee28ea34-ed07-47a7-60d2-fdee3473b499@windriver.com>
	<CAMKF1spW09mU-D4U0DwypHxwwEc5NUb1hAA=o-cZi8kpYd+BVA@mail.gmail.com>
	<f3e3d42a-8bfc-f80d-eb84-0965a6c06bd3@windriver.com>
	<3415ddb2-926a-24b3-94ad-beb58febdefa@windriver.com>
	<CAMKF1srvEyh-GtbUYUWXbHqsXm7isp8tX-fvTo_cF=9vGU+MNw@mail.gmail.com>
In-Reply-To: <CAMKF1srvEyh-GtbUYUWXbHqsXm7isp8tX-fvTo_cF=9vGU+MNw@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 18 Jan 2019 22:44:47 -0800
Message-ID: <CAMKF1srcUN6k2R-cV2xbw3MzE+Vym8i5_yfCsuFynRhzvEpj2A@mail.gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/7] gitsm.py: Fix when a submodule is defined, but not initialized
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
X-List-Received-Date: Sat, 19 Jan 2019 06:45:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mark

another regression

http://errors.yoctoproject.org/Errors/Details/217455/

http://cgit.openembedded.org/meta-openembedded/tree/meta-oe/recipes-core/db=
us/dbus-broker_git.bb?h=3Dmaster



On Fri, Jan 18, 2019 at 5:27 PM Khem Raj <raj.khem@gmail.com> wrote:
>
> I cherry picked this commit on top of master and I still see failure to u=
npack
>
> ERROR: cli11-1.6.2+gitAUTOINC+bd4dc91184-r0 do_unpack: Fetcher
> failure: Fetch command export PSEUDO_DISABLED=3D1; export
> DBUS_SESSION_BUS_ADDRESS=3D"unix:path=3D/run/user/1000/bus"; export
> SSH_AGENT_PID=3D"1235"; export SSH_AUTH_SOCK=3D"/tmp/ssh-agent.sock.1000"=
;
> export PATH=3D"/mnt/a/yoe/build/tmp/sysroots-uninative/x86_64-linux/usr/b=
in:/mnt/a/yoe/sources/openembedded-core/scripts:/mnt/a/yoe/build/tmp/work/c=
ortexa5t2hf-neon-vfpv4-yoe-linux-musleabi/cli11/1.6.2+gitAUTOINC+bd4dc91184=
-r0/recipe-sysroot-native/usr/bin/arm-yoe-linux-musleabi:/mnt/a/yoe/build/t=
mp/work/cortexa5t2hf-neon-vfpv4-yoe-linux-musleabi/cli11/1.6.2+gitAUTOINC+b=
d4dc91184-r0/recipe-sysroot/usr/bin/crossscripts:/mnt/a/yoe/build/tmp/work/=
cortexa5t2hf-neon-vfpv4-yoe-linux-musleabi/cli11/1.6.2+gitAUTOINC+bd4dc9118=
4-r0/recipe-sysroot-native/usr/sbin:/mnt/a/yoe/build/tmp/work/cortexa5t2hf-=
neon-vfpv4-yoe-linux-musleabi/cli11/1.6.2+gitAUTOINC+bd4dc91184-r0/recipe-s=
ysroot-native/usr/bin:/mnt/a/yoe/build/tmp/work/cortexa5t2hf-neon-vfpv4-yoe=
-linux-musleabi/cli11/1.6.2+gitAUTOINC+bd4dc91184-r0/recipe-sysroot-native/=
sbin:/mnt/a/yoe/build/tmp/work/cortexa5t2hf-neon-vfpv4-yoe-linux-musleabi/c=
li11/1.6.2+gitAUTOINC+bd4dc91184-r0/recipe-sysroot-native/bin:/mnt/a/yoe/so=
urces/bitbake/bin:/mnt/a/yoe/build/tmp/hosttools";
> export HOME=3D"/home/kraj"; git -c core.fsyncobjectfiles=3D0 config
> core.bare false
> ERROR: cli11-1.6.2+gitAUTOINC+bd4dc91184-r0 do_unpack: Function
> failed: base_do_unpack
> ERROR: Logfile of failure stored in:
> /mnt/a/yoe/build/tmp/work/cortexa5t2hf-neon-vfpv4-yoe-linux-musleabi/cli1=
1/1.6.2+gitAUTOINC+bd4dc91184-r0/temp/log.do_unpack.10171
> ERROR: Task (/mnt/a/yoe/sources/meta-openembedded/meta-oe/recipes-support=
/cli11/cli11_1.6.2.bb:do_unpack)
> failed with exit code '1'
>
> My bitbake tree is here
>
> https://github.com/YoeDistro/bitbake/commits/yoe/mut
>
> On Fri, Jan 18, 2019 at 3:06 PM Mark Hatle <mark.hatle@windriver.com> wro=
te:
> >
> > I think I have a fix for this.  Can you try the bitbake available from:
> >
> > git://git.openembedded.org/bitbake-contrib
> >
> > branch mgh/gitsm
> >
> > The commit that resolves this issue is:
> >
> > 0a7d8bd99a5ba394b00ed35593101b4cd324a58d
> >
> > --Mark
> >
> > On 1/18/19 3:20 PM, Mark Hatle wrote:
> > > On 1/18/19 12:31 PM, Khem Raj wrote:
> > >> On Fri, Jan 18, 2019 at 10:08 AM Mark Hatle <mark.hatle@windriver.co=
m> wrote:
> > >>>
> > >>> On 1/18/19 9:07 AM, Khem Raj wrote:
> > >>>>  I am seeing
> > >>>>
> > >>>> http://errors.yoctoproject.org/Errors/Details/217408/
> > >>>> http://errors.yoctoproject.org/Errors/Details/217412/
> > >>>
> > >>> Do you know where these failing recipes are so that I can reproduce=
 it locally?
> > >>>
> > >>> rwmem looks like it might be meta-ti?
> > >>> cli11 looks like something from meta-oe.
> > >>>
> > >>
> > >> yes thats right.
> > >> http://cgit.openembedded.org/meta-openembedded/tree/meta-oe/recipes-=
support/cli11/cli11_1.6.2.bb?h=3Dmaster
> > >>
> > >> gitsm version of rwmem is not yes applied in meta-ti so you might ha=
ve
> > >> to get it from my staging branch
> > >>
> > >> https://github.com/YoeDistro/meta-ti/commit/3418beda1869882d5f94dc40=
5d2727f09ffe20c4
> > >
> > > The reproducer appears to be that these repositories are 'git' based,=
 but use
> > > relative submodule locations from the main repository.
> > >
> > > So now the gitsm code needs to resolve relative URLs, which is someth=
ing not
> > > previously implemented.
> > >
> > > --Mark
> > >
> > >>> --Mark
> > >>>
> > >>>> On Tue, Jan 15, 2019 at 1:33 PM Mark Hatle <mark.hatle@windriver.c=
om> wrote:
> > >>>>>
> > >>>>> It is possible for a submodule to be defined in the .gitmodules f=
ile, but
> > >>>>> never initialized in the repository itself.  This shows itself wh=
en searching
> > >>>>> for the defined module hash you will get back a empty value.
> > >>>>>
> > >>>>> Similarly we need to identify and skip defined but not initialize=
d submodules
> > >>>>> during the unpack stages as well.
> > >>>>>
> > >>>>> Thanks to raphael.lisicki@siemens.com for their help is figuring =
out how
> > >>>>> to resolve this issue.
> > >>>>>
> > >>>>> Additionally a problem was found where, while unlikely, it may be=
 possible
> > >>>>> for the wrong revision to have been searched using ls-tree.  This=
 has been
> > >>>>> resolved in the update_submodules function by keeping the correct=
 revision
> > >>>>> along with the submodule path.
> > >>>>>
> > >>>>> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> > >>>>> ---
> > >>>>>  lib/bb/fetch2/gitsm.py | 32 ++++++++++++++++++++++++++++----
> > >>>>>  1 file changed, 28 insertions(+), 4 deletions(-)
> > >>>>>
> > >>>>> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> > >>>>> index 35729db..b7959ff 100644
> > >>>>> --- a/lib/bb/fetch2/gitsm.py
> > >>>>> +++ b/lib/bb/fetch2/gitsm.py
> > >>>>> @@ -64,6 +64,7 @@ class GitSM(Git):
> > >>>>>      def update_submodules(self, ud, d):
> > >>>>>          submodules =3D []
> > >>>>>          paths =3D {}
> > >>>>> +        revision =3D {}
> > >>>>>          uris =3D {}
> > >>>>>          local_paths =3D {}
> > >>>>>
> > >>>>> @@ -77,6 +78,7 @@ class GitSM(Git):
> > >>>>>              for m, md in self.parse_gitmodules(gitmodules).items=
():
> > >>>>>                  submodules.append(m)
> > >>>>>                  paths[m] =3D md['path']
> > >>>>> +                revision[m] =3D ud.revisions[name]
> > >>>>>                  uris[m] =3D md['url']
> > >>>>>                  if uris[m].startswith('..'):
> > >>>>>                      newud =3D copy.copy(ud)
> > >>>>> @@ -84,7 +86,17 @@ class GitSM(Git):
> > >>>>>                      uris[m] =3D Git._get_repo_url(self, newud)
> > >>>>>
> > >>>>>          for module in submodules:
> > >>>>> -            module_hash =3D runfetchcmd("%s ls-tree -z -d %s %s"=
 % (ud.basecmd, ud.revisions[name], paths[module]), d, quiet=3DTrue, workdi=
r=3Dud.clonedir)
> > >>>>> +            try:
> > >>>>> +                module_hash =3D runfetchcmd("%s ls-tree -z -d %s=
 %s" % (ud.basecmd, revision[module], paths[module]), d, quiet=3DTrue, work=
dir=3Dud.clonedir)
> > >>>>> +            except:
> > >>>>> +                # If the command fails, we don't have a valid fi=
le to check.  If it doesn't
> > >>>>> +                # fail -- it still might be a failure, see next =
check...
> > >>>>> +                module_hash =3D ""
> > >>>>> +
> > >>>>> +            if not module_hash:
> > >>>>> +                logger.debug(1, "submodule %s is defined, but is=
 not initialized in the repository. Skipping", module)
> > >>>>> +                continue
> > >>>>> +
> > >>>>>              module_hash =3D module_hash.split()[2]
> > >>>>>
> > >>>>>              # Build new SRC_URI
> > >>>>> @@ -143,7 +155,7 @@ class GitSM(Git):
> > >>>>>          if not ud.shallow or ud.localpath !=3D ud.fullshallow:
> > >>>>>              self.update_submodules(ud, d)
> > >>>>>
> > >>>>> -    def copy_submodules(self, submodules, ud, destdir, d):
> > >>>>> +    def copy_submodules(self, submodules, ud, name, destdir, d):
> > >>>>>          if ud.bareclone:
> > >>>>>              repo_conf =3D destdir
> > >>>>>          else:
> > >>>>> @@ -156,6 +168,18 @@ class GitSM(Git):
> > >>>>>              srcpath =3D os.path.join(ud.clonedir, 'modules', md[=
'path'])
> > >>>>>              modpath =3D os.path.join(repo_conf, 'modules', md['p=
ath'])
> > >>>>>
> > >>>>> +            # Check if the module is initialized
> > >>>>> +            try:
> > >>>>> +                module_hash =3D runfetchcmd("%s ls-tree -z -d %s=
 %s" % (ud.basecmd, ud.revisions[name], md['path']), d, quiet=3DTrue, workd=
ir=3Dud.clonedir)
> > >>>>> +            except:
> > >>>>> +                # If the command fails, we don't have a valid fi=
le to check.  If it doesn't
> > >>>>> +                # fail -- it still might be a failure, see next =
check...
> > >>>>> +                module_hash =3D ""
> > >>>>> +
> > >>>>> +            if not module_hash:
> > >>>>> +                logger.debug(1, "submodule %s is defined, but is=
 not initialized in the repository. Skipping", module)
> > >>>>> +                continue
> > >>>>> +
> > >>>>>              if os.path.exists(srcpath):
> > >>>>>                  if os.path.exists(os.path.join(srcpath, '.git'))=
:
> > >>>>>                      srcpath =3D os.path.join(srcpath, '.git')
> > >>>>> @@ -188,7 +212,7 @@ class GitSM(Git):
> > >>>>>                  continue
> > >>>>>
> > >>>>>              submodules =3D self.parse_gitmodules(gitmodules)
> > >>>>> -            self.copy_submodules(submodules, ud, dest, d)
> > >>>>> +            self.copy_submodules(submodules, ud, name, dest, d)
> > >>>>>
> > >>>>>      def unpack(self, ud, destdir, d):
> > >>>>>          Git.unpack(self, ud, destdir, d)
> > >>>>> @@ -211,7 +235,7 @@ class GitSM(Git):
> > >>>>>                  continue
> > >>>>>
> > >>>>>              submodules =3D self.parse_gitmodules(gitmodules)
> > >>>>> -            self.copy_submodules(submodules, ud, ud.destdir, d)
> > >>>>> +            self.copy_submodules(submodules, ud, name, ud.destdi=
r, d)
> > >>>>>
> > >>>>>              submodules_queue =3D [(module, os.path.join(repo_con=
f, 'modules', md['path'])) for module, md in submodules.items()]
> > >>>>>              while len(submodules_queue) !=3D 0:
> > >>>>> --
> > >>>>> 1.8.3.1
> > >>>>>
> > >>>>> --
> > >>>>> _______________________________________________
> > >>>>> bitbake-devel mailing list
> > >>>>> bitbake-devel@lists.openembedded.org
> > >>>>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> > >>>
> > >
> >

