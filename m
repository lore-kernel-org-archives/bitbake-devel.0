Return-Path: <raj.khem@gmail.com>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
	[209.85.222.194])
	by mail.openembedded.org (Postfix) with ESMTP id ED0886093F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Jan 2019 03:36:53 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id z18so407781qkj.10
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jan 2019 19:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=yOeY/RqCw2qa4ukR4lshnhUfw78jjlR3HVCFyBzH9ko=;
	b=BQKjRTSyDpsVyHDxKXw9qrK1UIqFFgwifkt52yGNNymLLPqy07mCLeOuPjmg8VDCt5
	nfRRjoGCR8Hnb9Hh1lhyRbeiwW80hRX6OgMjxIfz7htCAS1l9gDPPd59FGeLfJPnXA9r
	kw7D7q5B7o2OemEQWonKVzDXXWIezPJh14zk0XFwJh3k3nSWMW93+/rlssUWqAa0r63Q
	8XLXrhKAXVqGzPprqFl/1i7ZZDmkqKd6wZibUv0MnyIKoiKk/hCCpafdxLxBmOYaBJL/
	0ZiPFJ6XfAfOH9OwcUZiUMfn07JnwWX97+ne1K3aTctALJPL9gs895H3L/Ch838qbnRI
	DuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=yOeY/RqCw2qa4ukR4lshnhUfw78jjlR3HVCFyBzH9ko=;
	b=KWg+9va3Y69mDksmcPIKQucwKJzS5H+nINV/HaRw9Kp1k074/Bx74xMnHCO94/cZKF
	Krj2on+kjG8HklIlXXy7ZixSy3yCwL3+65V0TivwoSfrW7pOmQBLrKkl1cqCT1wLmrCF
	XU+MIxjZULRbTFeKjNre7ibtfnTmesmhobHoJXw6OimzFL9bgTldN7QY2SPqQ62jkMDk
	+isrOyWWHkvwGGnIdkCv7IFafXGziCOZ9fFFIWbPkwGZ500ven13h5czfnDPmQUwgfAM
	h3RW5s4hJiYY+DGlmAmMgCIriWoiTl2nXt8kZYYSUoGiOz50Wt6cSgZostMX1eVD9lB6
	0gEA==
X-Gm-Message-State: AJcUukeNXGeY44mQJtxH9LtGa/XFlAAfOdSL0DOuPDiEHyZzaaFI67l2
	UYHYTKuBNI0ty66ZmSyu5iXjMqU1x9ONrl7GYAtWrCob
X-Google-Smtp-Source: ALg8bN76zU+j36OX78IH2tsM7e3JE9AmvVexpQahxOknAtvxH+LaUJW1LgFHPu6JsUtvKFQo9dhpnJSUTF2cptKAbHo=
X-Received: by 2002:a37:ac05:: with SMTP id e5mr484710qkm.102.1548214614262;
	Tue, 22 Jan 2019 19:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20190115213137.113956-1-mark.hatle@windriver.com>
	<20190115213137.113956-2-mark.hatle@windriver.com>
	<CAMKF1srg335yq2xUtiLxvGkXMQPsTga-4UepQzFD0dem3RTrKw@mail.gmail.com>
	<ee28ea34-ed07-47a7-60d2-fdee3473b499@windriver.com>
	<CAMKF1spW09mU-D4U0DwypHxwwEc5NUb1hAA=o-cZi8kpYd+BVA@mail.gmail.com>
	<f3e3d42a-8bfc-f80d-eb84-0965a6c06bd3@windriver.com>
	<3415ddb2-926a-24b3-94ad-beb58febdefa@windriver.com>
	<CAMKF1srvEyh-GtbUYUWXbHqsXm7isp8tX-fvTo_cF=9vGU+MNw@mail.gmail.com>
	<CAMKF1srcUN6k2R-cV2xbw3MzE+Vym8i5_yfCsuFynRhzvEpj2A@mail.gmail.com>
	<c77391b2-1e02-c2b5-e87a-10006d48381e@windriver.com>
In-Reply-To: <c77391b2-1e02-c2b5-e87a-10006d48381e@windriver.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 22 Jan 2019 22:36:27 -0500
Message-ID: <CAMKF1sorFr0tvBQMJv69gbE52kHz=AGpEk-tr_g+D_bEH5jKmA@mail.gmail.com>
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
X-List-Received-Date: Wed, 23 Jan 2019 03:36:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It worked.

On Tue, Jan 22, 2019 at 3:43 PM Mark Hatle <mark.hatle@windriver.com> wrote=
:
>
> Sorry for the delay in getting a fix back to you..
>
> See:
>
> http://git.openembedded.org/bitbake-contrib/log/?h=3Dmgh/gitsm
>
> top two commits should resolve both this and the CLI11 issue.  (I am assu=
ming
> the third one is the same problem.)
>
> Can you please give this a try.. if it's working now, I'll send a formal =
pull
> request.
>
> --Mark
>
> On 1/19/19 12:44 AM, Khem Raj wrote:
> > Mark
> >
> > another regression
> >
> > http://errors.yoctoproject.org/Errors/Details/217455/
> >
> > http://cgit.openembedded.org/meta-openembedded/tree/meta-oe/recipes-cor=
e/dbus/dbus-broker_git.bb?h=3Dmaster
> >
> >
> >
> > On Fri, Jan 18, 2019 at 5:27 PM Khem Raj <raj.khem@gmail.com> wrote:
> >>
> >> I cherry picked this commit on top of master and I still see failure t=
o unpack
> >>
> >> ERROR: cli11-1.6.2+gitAUTOINC+bd4dc91184-r0 do_unpack: Fetcher
> >> failure: Fetch command export PSEUDO_DISABLED=3D1; export
> >> DBUS_SESSION_BUS_ADDRESS=3D"unix:path=3D/run/user/1000/bus"; export
> >> SSH_AGENT_PID=3D"1235"; export SSH_AUTH_SOCK=3D"/tmp/ssh-agent.sock.10=
00";
> >> export PATH=3D"/mnt/a/yoe/build/tmp/sysroots-uninative/x86_64-linux/us=
r/bin:/mnt/a/yoe/sources/openembedded-core/scripts:/mnt/a/yoe/build/tmp/wor=
k/cortexa5t2hf-neon-vfpv4-yoe-linux-musleabi/cli11/1.6.2+gitAUTOINC+bd4dc91=
184-r0/recipe-sysroot-native/usr/bin/arm-yoe-linux-musleabi:/mnt/a/yoe/buil=
d/tmp/work/cortexa5t2hf-neon-vfpv4-yoe-linux-musleabi/cli11/1.6.2+gitAUTOIN=
C+bd4dc91184-r0/recipe-sysroot/usr/bin/crossscripts:/mnt/a/yoe/build/tmp/wo=
rk/cortexa5t2hf-neon-vfpv4-yoe-linux-musleabi/cli11/1.6.2+gitAUTOINC+bd4dc9=
1184-r0/recipe-sysroot-native/usr/sbin:/mnt/a/yoe/build/tmp/work/cortexa5t2=
hf-neon-vfpv4-yoe-linux-musleabi/cli11/1.6.2+gitAUTOINC+bd4dc91184-r0/recip=
e-sysroot-native/usr/bin:/mnt/a/yoe/build/tmp/work/cortexa5t2hf-neon-vfpv4-=
yoe-linux-musleabi/cli11/1.6.2+gitAUTOINC+bd4dc91184-r0/recipe-sysroot-nati=
ve/sbin:/mnt/a/yoe/build/tmp/work/cortexa5t2hf-neon-vfpv4-yoe-linux-musleab=
i/cli11/1.6.2+gitAUTOINC+bd4dc91184-r0/recipe-sysroot-native/bin:/mnt/a/yoe=
/sources/bitbake/bin:/mnt/a/yoe/build/tmp/hosttools";
> >> export HOME=3D"/home/kraj"; git -c core.fsyncobjectfiles=3D0 config
> >> core.bare false
> >> ERROR: cli11-1.6.2+gitAUTOINC+bd4dc91184-r0 do_unpack: Function
> >> failed: base_do_unpack
> >> ERROR: Logfile of failure stored in:
> >> /mnt/a/yoe/build/tmp/work/cortexa5t2hf-neon-vfpv4-yoe-linux-musleabi/c=
li11/1.6.2+gitAUTOINC+bd4dc91184-r0/temp/log.do_unpack.10171
> >> ERROR: Task (/mnt/a/yoe/sources/meta-openembedded/meta-oe/recipes-supp=
ort/cli11/cli11_1.6.2.bb:do_unpack)
> >> failed with exit code '1'
> >>
> >> My bitbake tree is here
> >>
> >> https://github.com/YoeDistro/bitbake/commits/yoe/mut
> >>
> >> On Fri, Jan 18, 2019 at 3:06 PM Mark Hatle <mark.hatle@windriver.com> =
wrote:
> >>>
> >>> I think I have a fix for this.  Can you try the bitbake available fro=
m:
> >>>
> >>> git://git.openembedded.org/bitbake-contrib
> >>>
> >>> branch mgh/gitsm
> >>>
> >>> The commit that resolves this issue is:
> >>>
> >>> 0a7d8bd99a5ba394b00ed35593101b4cd324a58d
> >>>
> >>> --Mark
> >>>
> >>> On 1/18/19 3:20 PM, Mark Hatle wrote:
> >>>> On 1/18/19 12:31 PM, Khem Raj wrote:
> >>>>> On Fri, Jan 18, 2019 at 10:08 AM Mark Hatle <mark.hatle@windriver.c=
om> wrote:
> >>>>>>
> >>>>>> On 1/18/19 9:07 AM, Khem Raj wrote:
> >>>>>>>  I am seeing
> >>>>>>>
> >>>>>>> http://errors.yoctoproject.org/Errors/Details/217408/
> >>>>>>> http://errors.yoctoproject.org/Errors/Details/217412/
> >>>>>>
> >>>>>> Do you know where these failing recipes are so that I can reproduc=
e it locally?
> >>>>>>
> >>>>>> rwmem looks like it might be meta-ti?
> >>>>>> cli11 looks like something from meta-oe.
> >>>>>>
> >>>>>
> >>>>> yes thats right.
> >>>>> http://cgit.openembedded.org/meta-openembedded/tree/meta-oe/recipes=
-support/cli11/cli11_1.6.2.bb?h=3Dmaster
> >>>>>
> >>>>> gitsm version of rwmem is not yes applied in meta-ti so you might h=
ave
> >>>>> to get it from my staging branch
> >>>>>
> >>>>> https://github.com/YoeDistro/meta-ti/commit/3418beda1869882d5f94dc4=
05d2727f09ffe20c4
> >>>>
> >>>> The reproducer appears to be that these repositories are 'git' based=
, but use
> >>>> relative submodule locations from the main repository.
> >>>>
> >>>> So now the gitsm code needs to resolve relative URLs, which is somet=
hing not
> >>>> previously implemented.
> >>>>
> >>>> --Mark
> >>>>
> >>>>>> --Mark
> >>>>>>
> >>>>>>> On Tue, Jan 15, 2019 at 1:33 PM Mark Hatle <mark.hatle@windriver.=
com> wrote:
> >>>>>>>>
> >>>>>>>> It is possible for a submodule to be defined in the .gitmodules =
file, but
> >>>>>>>> never initialized in the repository itself.  This shows itself w=
hen searching
> >>>>>>>> for the defined module hash you will get back a empty value.
> >>>>>>>>
> >>>>>>>> Similarly we need to identify and skip defined but not initializ=
ed submodules
> >>>>>>>> during the unpack stages as well.
> >>>>>>>>
> >>>>>>>> Thanks to raphael.lisicki@siemens.com for their help is figuring=
 out how
> >>>>>>>> to resolve this issue.
> >>>>>>>>
> >>>>>>>> Additionally a problem was found where, while unlikely, it may b=
e possible
> >>>>>>>> for the wrong revision to have been searched using ls-tree.  Thi=
s has been
> >>>>>>>> resolved in the update_submodules function by keeping the correc=
t revision
> >>>>>>>> along with the submodule path.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> >>>>>>>> ---
> >>>>>>>>  lib/bb/fetch2/gitsm.py | 32 ++++++++++++++++++++++++++++----
> >>>>>>>>  1 file changed, 28 insertions(+), 4 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> >>>>>>>> index 35729db..b7959ff 100644
> >>>>>>>> --- a/lib/bb/fetch2/gitsm.py
> >>>>>>>> +++ b/lib/bb/fetch2/gitsm.py
> >>>>>>>> @@ -64,6 +64,7 @@ class GitSM(Git):
> >>>>>>>>      def update_submodules(self, ud, d):
> >>>>>>>>          submodules =3D []
> >>>>>>>>          paths =3D {}
> >>>>>>>> +        revision =3D {}
> >>>>>>>>          uris =3D {}
> >>>>>>>>          local_paths =3D {}
> >>>>>>>>
> >>>>>>>> @@ -77,6 +78,7 @@ class GitSM(Git):
> >>>>>>>>              for m, md in self.parse_gitmodules(gitmodules).item=
s():
> >>>>>>>>                  submodules.append(m)
> >>>>>>>>                  paths[m] =3D md['path']
> >>>>>>>> +                revision[m] =3D ud.revisions[name]
> >>>>>>>>                  uris[m] =3D md['url']
> >>>>>>>>                  if uris[m].startswith('..'):
> >>>>>>>>                      newud =3D copy.copy(ud)
> >>>>>>>> @@ -84,7 +86,17 @@ class GitSM(Git):
> >>>>>>>>                      uris[m] =3D Git._get_repo_url(self, newud)
> >>>>>>>>
> >>>>>>>>          for module in submodules:
> >>>>>>>> -            module_hash =3D runfetchcmd("%s ls-tree -z -d %s %s=
" % (ud.basecmd, ud.revisions[name], paths[module]), d, quiet=3DTrue, workd=
ir=3Dud.clonedir)
> >>>>>>>> +            try:
> >>>>>>>> +                module_hash =3D runfetchcmd("%s ls-tree -z -d %=
s %s" % (ud.basecmd, revision[module], paths[module]), d, quiet=3DTrue, wor=
kdir=3Dud.clonedir)
> >>>>>>>> +            except:
> >>>>>>>> +                # If the command fails, we don't have a valid f=
ile to check.  If it doesn't
> >>>>>>>> +                # fail -- it still might be a failure, see next=
 check...
> >>>>>>>> +                module_hash =3D ""
> >>>>>>>> +
> >>>>>>>> +            if not module_hash:
> >>>>>>>> +                logger.debug(1, "submodule %s is defined, but i=
s not initialized in the repository. Skipping", module)
> >>>>>>>> +                continue
> >>>>>>>> +
> >>>>>>>>              module_hash =3D module_hash.split()[2]
> >>>>>>>>
> >>>>>>>>              # Build new SRC_URI
> >>>>>>>> @@ -143,7 +155,7 @@ class GitSM(Git):
> >>>>>>>>          if not ud.shallow or ud.localpath !=3D ud.fullshallow:
> >>>>>>>>              self.update_submodules(ud, d)
> >>>>>>>>
> >>>>>>>> -    def copy_submodules(self, submodules, ud, destdir, d):
> >>>>>>>> +    def copy_submodules(self, submodules, ud, name, destdir, d)=
:
> >>>>>>>>          if ud.bareclone:
> >>>>>>>>              repo_conf =3D destdir
> >>>>>>>>          else:
> >>>>>>>> @@ -156,6 +168,18 @@ class GitSM(Git):
> >>>>>>>>              srcpath =3D os.path.join(ud.clonedir, 'modules', md=
['path'])
> >>>>>>>>              modpath =3D os.path.join(repo_conf, 'modules', md['=
path'])
> >>>>>>>>
> >>>>>>>> +            # Check if the module is initialized
> >>>>>>>> +            try:
> >>>>>>>> +                module_hash =3D runfetchcmd("%s ls-tree -z -d %=
s %s" % (ud.basecmd, ud.revisions[name], md['path']), d, quiet=3DTrue, work=
dir=3Dud.clonedir)
> >>>>>>>> +            except:
> >>>>>>>> +                # If the command fails, we don't have a valid f=
ile to check.  If it doesn't
> >>>>>>>> +                # fail -- it still might be a failure, see next=
 check...
> >>>>>>>> +                module_hash =3D ""
> >>>>>>>> +
> >>>>>>>> +            if not module_hash:
> >>>>>>>> +                logger.debug(1, "submodule %s is defined, but i=
s not initialized in the repository. Skipping", module)
> >>>>>>>> +                continue
> >>>>>>>> +
> >>>>>>>>              if os.path.exists(srcpath):
> >>>>>>>>                  if os.path.exists(os.path.join(srcpath, '.git')=
):
> >>>>>>>>                      srcpath =3D os.path.join(srcpath, '.git')
> >>>>>>>> @@ -188,7 +212,7 @@ class GitSM(Git):
> >>>>>>>>                  continue
> >>>>>>>>
> >>>>>>>>              submodules =3D self.parse_gitmodules(gitmodules)
> >>>>>>>> -            self.copy_submodules(submodules, ud, dest, d)
> >>>>>>>> +            self.copy_submodules(submodules, ud, name, dest, d)
> >>>>>>>>
> >>>>>>>>      def unpack(self, ud, destdir, d):
> >>>>>>>>          Git.unpack(self, ud, destdir, d)
> >>>>>>>> @@ -211,7 +235,7 @@ class GitSM(Git):
> >>>>>>>>                  continue
> >>>>>>>>
> >>>>>>>>              submodules =3D self.parse_gitmodules(gitmodules)
> >>>>>>>> -            self.copy_submodules(submodules, ud, ud.destdir, d)
> >>>>>>>> +            self.copy_submodules(submodules, ud, name, ud.destd=
ir, d)
> >>>>>>>>
> >>>>>>>>              submodules_queue =3D [(module, os.path.join(repo_co=
nf, 'modules', md['path'])) for module, md in submodules.items()]
> >>>>>>>>              while len(submodules_queue) !=3D 0:
> >>>>>>>> --
> >>>>>>>> 1.8.3.1
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> _______________________________________________
> >>>>>>>> bitbake-devel mailing list
> >>>>>>>> bitbake-devel@lists.openembedded.org
> >>>>>>>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> >>>>>>
> >>>>
> >>>
>

