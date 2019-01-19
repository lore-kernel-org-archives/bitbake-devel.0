Return-Path: <raj.khem@gmail.com>
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
	[209.85.160.193])
	by mail.openembedded.org (Postfix) with ESMTP id 0B1147BE17
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 19 Jan 2019 01:27:37 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id n32so17293388qte.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 17:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=LTNgsVt6TpxtwkWx8H7TnxQKQTJTYoF5xHMUabGHMiE=;
	b=rvq1+DBji0EXkpOQ63I8bzh8s62ZYmxMYp9bG/zSEZ2tQ1KxCC8bacGurNbfB9SgiV
	Lmu3fA32yE8Iw3HOa+Z8DsIz4Q8mwLZkgfgoQJQCCaWpcwmVHyReA76JqZeP9fVCvLUR
	y31o9uKh1y8IYW36r+CoFoZL88tS+qfGa6tK8JbS8F70RnYuvVyoh6NBzipLG0k563My
	ECKAoREcwcTkMIlyz1kUkZKN/7e2Ah6Z6zm6C0++eyNe84qivzd6H0GL7pvLq0eDBcP9
	i212H6YQiClGJHdfhlaICk0CRkSirwUEElfVyAQmU/VyLriZiwqpfogsxu8KscEVeyaU
	HuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=LTNgsVt6TpxtwkWx8H7TnxQKQTJTYoF5xHMUabGHMiE=;
	b=gTFkOBOGiIxQL7Mon8haZeJyYqg6ffGffne6tMyT/VFsgzwH3Pc1VkpUmQYHEqd+FN
	a7KHgf2D5kMd2avlK3XA0ssGRZ/OzDUI9WNDUd3S4y1wKR/5oceEbR9R72LD/UZ8DC3B
	uaWG5YtzlFKs76iG27hITtqFc8Cz7hr63lqh41jQqyBSUYby8eVZCXQSqAU/CAVzeWsU
	4tRXBrR/RzXT/+P/bOjTVuNQmMFhU6t70V8arehjSH/6MJPUyMDQaK1MuB7KPz1hrNSz
	4955mgveuS+GePh7bppS+BFe4sNC9mJ1BBfduCBzbRv0pGgNnrlkCFeJuxcu/Kut8R+G
	2C9A==
X-Gm-Message-State: AJcUukcjgAfm+aOvPhAxNACWIYZAxOT4bA+DjZuGACevLC+XsZhehJjf
	9ivhnBLdbtDI2aHYLc+jlRG8Hh/dQptGvhp16AI=
X-Google-Smtp-Source: ALg8bN5T5QnZZiDoCHcWlzpPRNwlcFMgfAeo3EMjD5ZtMEtxpdgVBzaTFEbJfNy5c7OWurHkqnJKdDofCHQyZmTxl6w=
X-Received: by 2002:aed:3a22:: with SMTP id n31mr18350780qte.29.1547861258678; 
	Fri, 18 Jan 2019 17:27:38 -0800 (PST)
MIME-Version: 1.0
References: <20190115213137.113956-1-mark.hatle@windriver.com>
	<20190115213137.113956-2-mark.hatle@windriver.com>
	<CAMKF1srg335yq2xUtiLxvGkXMQPsTga-4UepQzFD0dem3RTrKw@mail.gmail.com>
	<ee28ea34-ed07-47a7-60d2-fdee3473b499@windriver.com>
	<CAMKF1spW09mU-D4U0DwypHxwwEc5NUb1hAA=o-cZi8kpYd+BVA@mail.gmail.com>
	<f3e3d42a-8bfc-f80d-eb84-0965a6c06bd3@windriver.com>
	<3415ddb2-926a-24b3-94ad-beb58febdefa@windriver.com>
In-Reply-To: <3415ddb2-926a-24b3-94ad-beb58febdefa@windriver.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 18 Jan 2019 17:27:12 -0800
Message-ID: <CAMKF1srvEyh-GtbUYUWXbHqsXm7isp8tX-fvTo_cF=9vGU+MNw@mail.gmail.com>
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
X-List-Received-Date: Sat, 19 Jan 2019 01:27:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I cherry picked this commit on top of master and I still see failure to unp=
ack

ERROR: cli11-1.6.2+gitAUTOINC+bd4dc91184-r0 do_unpack: Fetcher
failure: Fetch command export PSEUDO_DISABLED=3D1; export
DBUS_SESSION_BUS_ADDRESS=3D"unix:path=3D/run/user/1000/bus"; export
SSH_AGENT_PID=3D"1235"; export SSH_AUTH_SOCK=3D"/tmp/ssh-agent.sock.1000";
export PATH=3D"/mnt/a/yoe/build/tmp/sysroots-uninative/x86_64-linux/usr/bin=
:/mnt/a/yoe/sources/openembedded-core/scripts:/mnt/a/yoe/build/tmp/work/cor=
texa5t2hf-neon-vfpv4-yoe-linux-musleabi/cli11/1.6.2+gitAUTOINC+bd4dc91184-r=
0/recipe-sysroot-native/usr/bin/arm-yoe-linux-musleabi:/mnt/a/yoe/build/tmp=
/work/cortexa5t2hf-neon-vfpv4-yoe-linux-musleabi/cli11/1.6.2+gitAUTOINC+bd4=
dc91184-r0/recipe-sysroot/usr/bin/crossscripts:/mnt/a/yoe/build/tmp/work/co=
rtexa5t2hf-neon-vfpv4-yoe-linux-musleabi/cli11/1.6.2+gitAUTOINC+bd4dc91184-=
r0/recipe-sysroot-native/usr/sbin:/mnt/a/yoe/build/tmp/work/cortexa5t2hf-ne=
on-vfpv4-yoe-linux-musleabi/cli11/1.6.2+gitAUTOINC+bd4dc91184-r0/recipe-sys=
root-native/usr/bin:/mnt/a/yoe/build/tmp/work/cortexa5t2hf-neon-vfpv4-yoe-l=
inux-musleabi/cli11/1.6.2+gitAUTOINC+bd4dc91184-r0/recipe-sysroot-native/sb=
in:/mnt/a/yoe/build/tmp/work/cortexa5t2hf-neon-vfpv4-yoe-linux-musleabi/cli=
11/1.6.2+gitAUTOINC+bd4dc91184-r0/recipe-sysroot-native/bin:/mnt/a/yoe/sour=
ces/bitbake/bin:/mnt/a/yoe/build/tmp/hosttools";
export HOME=3D"/home/kraj"; git -c core.fsyncobjectfiles=3D0 config
core.bare false
ERROR: cli11-1.6.2+gitAUTOINC+bd4dc91184-r0 do_unpack: Function
failed: base_do_unpack
ERROR: Logfile of failure stored in:
/mnt/a/yoe/build/tmp/work/cortexa5t2hf-neon-vfpv4-yoe-linux-musleabi/cli11/=
1.6.2+gitAUTOINC+bd4dc91184-r0/temp/log.do_unpack.10171
ERROR: Task (/mnt/a/yoe/sources/meta-openembedded/meta-oe/recipes-support/c=
li11/cli11_1.6.2.bb:do_unpack)
failed with exit code '1'

My bitbake tree is here

https://github.com/YoeDistro/bitbake/commits/yoe/mut

On Fri, Jan 18, 2019 at 3:06 PM Mark Hatle <mark.hatle@windriver.com> wrote=
:
>
> I think I have a fix for this.  Can you try the bitbake available from:
>
> git://git.openembedded.org/bitbake-contrib
>
> branch mgh/gitsm
>
> The commit that resolves this issue is:
>
> 0a7d8bd99a5ba394b00ed35593101b4cd324a58d
>
> --Mark
>
> On 1/18/19 3:20 PM, Mark Hatle wrote:
> > On 1/18/19 12:31 PM, Khem Raj wrote:
> >> On Fri, Jan 18, 2019 at 10:08 AM Mark Hatle <mark.hatle@windriver.com>=
 wrote:
> >>>
> >>> On 1/18/19 9:07 AM, Khem Raj wrote:
> >>>>  I am seeing
> >>>>
> >>>> http://errors.yoctoproject.org/Errors/Details/217408/
> >>>> http://errors.yoctoproject.org/Errors/Details/217412/
> >>>
> >>> Do you know where these failing recipes are so that I can reproduce i=
t locally?
> >>>
> >>> rwmem looks like it might be meta-ti?
> >>> cli11 looks like something from meta-oe.
> >>>
> >>
> >> yes thats right.
> >> http://cgit.openembedded.org/meta-openembedded/tree/meta-oe/recipes-su=
pport/cli11/cli11_1.6.2.bb?h=3Dmaster
> >>
> >> gitsm version of rwmem is not yes applied in meta-ti so you might have
> >> to get it from my staging branch
> >>
> >> https://github.com/YoeDistro/meta-ti/commit/3418beda1869882d5f94dc405d=
2727f09ffe20c4
> >
> > The reproducer appears to be that these repositories are 'git' based, b=
ut use
> > relative submodule locations from the main repository.
> >
> > So now the gitsm code needs to resolve relative URLs, which is somethin=
g not
> > previously implemented.
> >
> > --Mark
> >
> >>> --Mark
> >>>
> >>>> On Tue, Jan 15, 2019 at 1:33 PM Mark Hatle <mark.hatle@windriver.com=
> wrote:
> >>>>>
> >>>>> It is possible for a submodule to be defined in the .gitmodules fil=
e, but
> >>>>> never initialized in the repository itself.  This shows itself when=
 searching
> >>>>> for the defined module hash you will get back a empty value.
> >>>>>
> >>>>> Similarly we need to identify and skip defined but not initialized =
submodules
> >>>>> during the unpack stages as well.
> >>>>>
> >>>>> Thanks to raphael.lisicki@siemens.com for their help is figuring ou=
t how
> >>>>> to resolve this issue.
> >>>>>
> >>>>> Additionally a problem was found where, while unlikely, it may be p=
ossible
> >>>>> for the wrong revision to have been searched using ls-tree.  This h=
as been
> >>>>> resolved in the update_submodules function by keeping the correct r=
evision
> >>>>> along with the submodule path.
> >>>>>
> >>>>> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> >>>>> ---
> >>>>>  lib/bb/fetch2/gitsm.py | 32 ++++++++++++++++++++++++++++----
> >>>>>  1 file changed, 28 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> >>>>> index 35729db..b7959ff 100644
> >>>>> --- a/lib/bb/fetch2/gitsm.py
> >>>>> +++ b/lib/bb/fetch2/gitsm.py
> >>>>> @@ -64,6 +64,7 @@ class GitSM(Git):
> >>>>>      def update_submodules(self, ud, d):
> >>>>>          submodules =3D []
> >>>>>          paths =3D {}
> >>>>> +        revision =3D {}
> >>>>>          uris =3D {}
> >>>>>          local_paths =3D {}
> >>>>>
> >>>>> @@ -77,6 +78,7 @@ class GitSM(Git):
> >>>>>              for m, md in self.parse_gitmodules(gitmodules).items()=
:
> >>>>>                  submodules.append(m)
> >>>>>                  paths[m] =3D md['path']
> >>>>> +                revision[m] =3D ud.revisions[name]
> >>>>>                  uris[m] =3D md['url']
> >>>>>                  if uris[m].startswith('..'):
> >>>>>                      newud =3D copy.copy(ud)
> >>>>> @@ -84,7 +86,17 @@ class GitSM(Git):
> >>>>>                      uris[m] =3D Git._get_repo_url(self, newud)
> >>>>>
> >>>>>          for module in submodules:
> >>>>> -            module_hash =3D runfetchcmd("%s ls-tree -z -d %s %s" %=
 (ud.basecmd, ud.revisions[name], paths[module]), d, quiet=3DTrue, workdir=
=3Dud.clonedir)
> >>>>> +            try:
> >>>>> +                module_hash =3D runfetchcmd("%s ls-tree -z -d %s %=
s" % (ud.basecmd, revision[module], paths[module]), d, quiet=3DTrue, workdi=
r=3Dud.clonedir)
> >>>>> +            except:
> >>>>> +                # If the command fails, we don't have a valid file=
 to check.  If it doesn't
> >>>>> +                # fail -- it still might be a failure, see next ch=
eck...
> >>>>> +                module_hash =3D ""
> >>>>> +
> >>>>> +            if not module_hash:
> >>>>> +                logger.debug(1, "submodule %s is defined, but is n=
ot initialized in the repository. Skipping", module)
> >>>>> +                continue
> >>>>> +
> >>>>>              module_hash =3D module_hash.split()[2]
> >>>>>
> >>>>>              # Build new SRC_URI
> >>>>> @@ -143,7 +155,7 @@ class GitSM(Git):
> >>>>>          if not ud.shallow or ud.localpath !=3D ud.fullshallow:
> >>>>>              self.update_submodules(ud, d)
> >>>>>
> >>>>> -    def copy_submodules(self, submodules, ud, destdir, d):
> >>>>> +    def copy_submodules(self, submodules, ud, name, destdir, d):
> >>>>>          if ud.bareclone:
> >>>>>              repo_conf =3D destdir
> >>>>>          else:
> >>>>> @@ -156,6 +168,18 @@ class GitSM(Git):
> >>>>>              srcpath =3D os.path.join(ud.clonedir, 'modules', md['p=
ath'])
> >>>>>              modpath =3D os.path.join(repo_conf, 'modules', md['pat=
h'])
> >>>>>
> >>>>> +            # Check if the module is initialized
> >>>>> +            try:
> >>>>> +                module_hash =3D runfetchcmd("%s ls-tree -z -d %s %=
s" % (ud.basecmd, ud.revisions[name], md['path']), d, quiet=3DTrue, workdir=
=3Dud.clonedir)
> >>>>> +            except:
> >>>>> +                # If the command fails, we don't have a valid file=
 to check.  If it doesn't
> >>>>> +                # fail -- it still might be a failure, see next ch=
eck...
> >>>>> +                module_hash =3D ""
> >>>>> +
> >>>>> +            if not module_hash:
> >>>>> +                logger.debug(1, "submodule %s is defined, but is n=
ot initialized in the repository. Skipping", module)
> >>>>> +                continue
> >>>>> +
> >>>>>              if os.path.exists(srcpath):
> >>>>>                  if os.path.exists(os.path.join(srcpath, '.git')):
> >>>>>                      srcpath =3D os.path.join(srcpath, '.git')
> >>>>> @@ -188,7 +212,7 @@ class GitSM(Git):
> >>>>>                  continue
> >>>>>
> >>>>>              submodules =3D self.parse_gitmodules(gitmodules)
> >>>>> -            self.copy_submodules(submodules, ud, dest, d)
> >>>>> +            self.copy_submodules(submodules, ud, name, dest, d)
> >>>>>
> >>>>>      def unpack(self, ud, destdir, d):
> >>>>>          Git.unpack(self, ud, destdir, d)
> >>>>> @@ -211,7 +235,7 @@ class GitSM(Git):
> >>>>>                  continue
> >>>>>
> >>>>>              submodules =3D self.parse_gitmodules(gitmodules)
> >>>>> -            self.copy_submodules(submodules, ud, ud.destdir, d)
> >>>>> +            self.copy_submodules(submodules, ud, name, ud.destdir,=
 d)
> >>>>>
> >>>>>              submodules_queue =3D [(module, os.path.join(repo_conf,=
 'modules', md['path'])) for module, md in submodules.items()]
> >>>>>              while len(submodules_queue) !=3D 0:
> >>>>> --
> >>>>> 1.8.3.1
> >>>>>
> >>>>> --
> >>>>> _______________________________________________
> >>>>> bitbake-devel mailing list
> >>>>> bitbake-devel@lists.openembedded.org
> >>>>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> >>>
> >
>

