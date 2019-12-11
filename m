Return-Path: <jpewhacker@gmail.com>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail.openembedded.org (Postfix) with ESMTP id 281767F935;
	Wed, 11 Dec 2019 04:03:31 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id z7so22341072wrl.13;
	Tue, 10 Dec 2019 20:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Zq7OV1IyJwY9NTpHei5qvE0MXJfrbvomM25JX8CMNLw=;
	b=lJMSI8Pf/z0Y2I9DmMMdpoGsL5cERr6OaQQSMk01CmmX4n0TPCZOtoTTsOWbAT8qg4
	9u5DFcUhR9PeHuyK+9w4Rw2Od/eyitlu8A2U4vYmcozBluZuQ9XOrf4+j6Cy4fW+CwWP
	A4Ya6VmzXWmhVDKjNDpsV+XzjkPe0ItMuQbH84YbKLEQa3mb8tOv8UpAfQqhPqrthhKL
	oR1V3zkrJg5Lr+KgIVaRLc84UaUZJhKTjK0eET2X+WxHdCO6JAksLQoTnNQ7ccU8Qg6M
	IN2Nir87PCfP5dHNyslqeuYEi9vkp84GhzTpu/FltY0JfBMP9H8evzHSucnzJHlxTMVs
	3oOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Zq7OV1IyJwY9NTpHei5qvE0MXJfrbvomM25JX8CMNLw=;
	b=Zkvz9X7iXdQE9Ipf4y4uyQ6S0n89ueh82XtwtHekweEtvamc9/cQRHn46+zEhG+odP
	FRMCieF4b/kZL+r48lVYtMU8pibT4nYOeQzlfeG0zygqHj/2xXvzbXFLAyQxGHvHlJP2
	PjduIJ4rL6iKI2MNopDz2S9fIu+eGCttdroDz/rX41KYdK/GE6qcMhSmBE0LsarzrC3B
	3JhozElXVQ51CCjvCg+cbJoIiK4IPLAStIomo4vIVPwVcIDIP1C2xAkhPIcO6vWkPI8w
	vTwV5NTxDCIHhXW9h1h3YWZZiJBKE4NQmsW83uC/hILnNSftmFMw8FBPIN1XY79Nrtpu
	56Kg==
X-Gm-Message-State: APjAAAW9oPNOBWSXujBivYh+TFc9H1o5/1atjST9ME98KTpcVWuVSp1J
	NGZZYfMhJmaqgpXtnL8DrddxVkmbOFHI9g6zCJ2bSpguOMI=
X-Google-Smtp-Source: APXvYqwlCiSmcF90CrDVCN8d1NVGhm0n4IDMc0cR6y1DLBaSgAMgQJhcBbwSE7eo9VOhMDMEWnzt9AN52Dx51q+fhBw=
X-Received: by 2002:a5d:67c7:: with SMTP id n7mr1027010wrw.319.1576037011678; 
	Tue, 10 Dec 2019 20:03:31 -0800 (PST)
MIME-Version: 1.0
References: <CY4PR12MB16537AC33CB9D19F94A126458B5A0@CY4PR12MB1653.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB16537AC33CB9D19F94A126458B5A0@CY4PR12MB1653.namprd12.prod.outlook.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 10 Dec 2019 22:03:20 -0600
Message-ID: <CAJdd5GZ0LTrTtU=gYMp0ZqTwQA9UQyU7WMx6mNG2scv--7wNVw@mail.gmail.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"Openembedded-core@lists.openembedded.org"
	<Openembedded-core@lists.openembedded.org>
Subject: Re: hashequiv, pseudo, and GIDs
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
X-List-Received-Date: Wed, 11 Dec 2019 04:03:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 7:51 PM chris.laplante--- via bitbake-devel
<bitbake-devel@lists.openembedded.org> wrote:
>
> Hello all,
>
> I'm encountering a failure like below when using hashequiv. What is happe=
ning is recipe "A" is installing some files in do_install, and changing the=
 group of those files. The group is defined by a different recipe ("B"). Th=
ere is no dependency between A and B, so when A:do_package runs, the group =
is not present in A's pseudo database. OEOuthashBasic tries to lookup the o=
wning group name of the file, and a KeyError is raised.
>
> A workaround is to add:
>     DEPENDS +=3D "B"
> to recipe A, so that the group ends up in A's pseudo database. This works=
, but seems really really hacky, since it's only necessary when hashequiv i=
s active.

That doesn't quite make sense to me... It seems like you *should* have
the dependency on B to pull in the group that the do_install()
requires?

>
> So why is the group name used in the hash, as opposed to the GID? (I also=
 have the same question regarding user name vs UID). If the GID was used we=
 wouldn't have this issue.

That was done in response to this mailing list thread:
http://lists.openembedded.org/pipermail/openembedded-core/2019-January/2777=
55.html

Basically, the GID and UID aren't stable values across builds so the
suggestion was to use the names. My understanding was that this
corresponded to how the user and groups are dealt with in general.

>
> Thanks,
> Chris
>
>
> ______________
> ERROR: A-1.0-r0 do_package: Error executing a python function in exec_pyt=
hon_func() autogenerated:
>
> The stack trace of python calls that resulted in this exception/failure w=
as:
> File: 'exec_python_func() autogenerated', lineno: 2, function: <module>
>      0001:
>  *** 0002:sstate_report_unihash(d)
>      0003:
> File: '/home/laplante/yocto/sources/poky/meta/classes/sstate.bbclass', li=
neno: 802, function: sstate_report_unihash
>      0798:    report_unihash =3D getattr(bb.parse.siggen, 'report_unihash=
', None)
>      0799:
>      0800:    if report_unihash:
>      0801:        ss =3D sstate_state_fromvars(d)
>  *** 0802:        report_unihash(os.getcwd(), ss['task'], d)
>      0803:}
>      0804:
>      0805:#
>      0806:# Shell function to decompress and prepare a package for instal=
lation
> File: '/home/laplante/yocto/sources/poky/bitbake/lib/bb/siggen.py', linen=
o: 485, function: report_unihash
>      0481:
>      0482:            if "." in self.method:
>      0483:                (module, method) =3D self.method.rsplit('.', 1)
>      0484:                locs['method'] =3D getattr(importlib.import_mod=
ule(module), method)
>  *** 0485:                outhash =3D bb.utils.better_eval('method(path, =
sigfile, task, d)', locs)
>      0486:            else:
>      0487:                outhash =3D bb.utils.better_eval(self.method + =
'(path, sigfile, task, d)', locs)
>      0488:
>      0489:            try:
> File: '/home/laplante/yocto/sources/poky/bitbake/lib/bb/utils.py', lineno=
: 421, function: better_eval
>      0417:    if extraglobals:
>      0418:        ctx =3D copy.copy(ctx)
>      0419:        for g in extraglobals:
>      0420:            ctx[g] =3D extraglobals[g]
>  *** 0421:    return eval(source, ctx, locals)
>      0422:
>      0423:@contextmanager
>      0424:def fileslocked(files):
>      0425:    """Context manager for locking and unlocking file locks."""
> File: '<string>', lineno: 1, function: <module>
>   File "<string>", line 1, in <module>
>
> File: '/home/laplante/yocto/sources/poky/meta/lib/oe/sstatesig.py', linen=
o: 553, function: OEOuthashBasic
>      0549:            process(root)
>      0550:            for f in files:
>      0551:                if f =3D=3D 'fixmepath':
>      0552:                    continue
>  *** 0553:                process(os.path.join(root, f))
>      0554:    finally:
>      0555:        os.chdir(prev_dir)
>      0556:
>      0557:    return h.hexdigest()
> File: '/home/laplante/yocto/sources/poky/meta/lib/oe/sstatesig.py', linen=
o: 516, function: process
>      0512:                    add_perm(stat.S_IXOTH, 'x')
>      0513:
>      0514:                if include_owners:
>      0515:                    update_hash(" %10s" % pwd.getpwuid(s.st_uid=
).pw_name)
>  *** 0516:                    update_hash(" %10s" % grp.getgrgid(s.st_gid=
).gr_name)
>      0517:
>      0518:                update_hash(" ")
>      0519:                if stat.S_ISBLK(s.st_mode) or stat.S_ISCHR(s.st=
_mode):
>      0520:                    update_hash("%9s" % ("%d.%d" % (os.major(s.=
st_rdev), os.minor(s.st_rdev))))
> Exception: KeyError: 'getgrgid(): gid not found: 3004'
> ______________
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

