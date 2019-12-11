Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr690077.outbound.protection.outlook.com [40.107.69.77])
	by mail.openembedded.org (Postfix) with ESMTP id E31447F968;
	Wed, 11 Dec 2019 01:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=GNKyH0OEolNy17ma+uADzkP1R99BZxhlarvuOtdNTqobgAdlG3y64owLeySTKiDw2WDWi/lgathzl99zR9ZMrv6143PtxfUOJuBL9bvNajN44rOvBRdJRfwuDtE2/WDleef015JjkU6QdnfNptszpSWqxObaZlIVFU0/FqWdUoMTcY/BPzLAc3Szr9xIin8BPkzjB6YvilP60gRT4hV2I/nTy92oTmP2MLejkRQe3Nk4aL69/w2ISOITDro+Sh80dXzQ5hW6wqbJA+m3YxE3vA2r87FIGosmiYSsBAx7PMfoYX2aL9i4sDd3RdaJZGrQjf54awzZzOHwshNGT6gRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=e7kiVUy0bQKdepHp9DA2wcQT/tA1BmtK9PpOOp/vdq8=;
	b=HT10sZsEb5hQcwp/5ZxECvADQSyDL4YzAfhoi5tlV9Shc0a0xauy5yiiX9dZvqzn89QB3xEYB+1e7YFejJbgUen6PYXeF2Btt8IGhsnYepHkrCAxgry++5S+dmoMFBv9er2y0BZLxIVS8DGShWI/tm/rD/TcRbpOFynN+iqZsiPvEH5XW9l4X/h7VFaVe8C8aECMbkUC8Lrra5QvGcRonBolMie89vKdVrahFq4q9r5SJYqOZGcIRrd7ou867xWhQHtWUre1S7SNUmqWt6r92oZD8EiKUFeMmODee/GfilUkRbrZGCkGbXPN6wcdPlWKEgAnH3VNU334oXJ49N1k7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=e7kiVUy0bQKdepHp9DA2wcQT/tA1BmtK9PpOOp/vdq8=;
	b=C65u77A6+h0GrWzvnWyak5gel25jnPmMMBeh2lqFddcMaoK5LkOXksVEopFhRO191oRZRp65VDO26kRVz3VdjtITiRJoIksInidLp8DDTjLSCHvV9lD5V+dzmoyiGtQwa927A450uWyh1XJXJvGzHinsU/pkeI2VZm2/77o26d4=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1221.namprd12.prod.outlook.com (10.168.167.8) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2516.17; Wed, 11 Dec 2019 01:51:10 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::8048:9c4a:16a1:f584]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::8048:9c4a:16a1:f584%4]) with mapi id 15.20.2516.018;
	Wed, 11 Dec 2019 01:51:10 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "Openembedded-core@lists.openembedded.org"
	<Openembedded-core@lists.openembedded.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: hashequiv, pseudo, and GIDs
Thread-Index: AdWvxXGeOYsqYFTMSCmAlM1iHqCZyQ==
Date: Wed, 11 Dec 2019 01:51:10 +0000
Message-ID: <CY4PR12MB16537AC33CB9D19F94A126458B5A0@CY4PR12MB1653.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82efabbf-7829-4194-3162-08d77ddc98d1
x-ms-traffictypediagnostic: CY4PR12MB1221:
x-microsoft-antispam-prvs: <CY4PR12MB12218B2E6B977BA4DE97AAE68B5A0@CY4PR12MB1221.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(346002)(366004)(376002)(136003)(396003)(29502001)(199004)(189003)(53754006)(33656002)(186003)(66476007)(66946007)(66556008)(76116006)(5660300002)(81156014)(9686003)(7696005)(81166006)(66446008)(8676002)(450100002)(8936002)(52536014)(2906002)(26005)(316002)(64756008)(478600001)(55016002)(86362001)(110136005)(6506007)(71200400001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1221;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aRVH5+FfmDcKALjKqa9T36wiPK/1YdzwnzV7jJNMmFYbJc5tp1UlqVMfjA9dTIAR1MhZdYttZmdEqHurKf+r2W5of8nsxq9eNXCrHs3CESLC8jCBtNoT7sTp68xo7XAEjGzammK5WHHjlFXYmxkDJHRXfo2WA4tD64VOhtQDHrO3dseZHcGbovQ4O7XABVWop2XNgWWdQpvvSgTdNzF7t2Sji2RCv1/7/ZqMKN0R9O5E3K5Re/FWdo3XfjBk6ITs8mBxIg4Fz734u1oq94JY8cGgmBSdKgKArh/FPlQnkT1czyxXFeH1xGKthA430LW+maw2l8jzV4FGJWjbDLY8p9/ZxOioutkl3fnfHVVFgE/vh1zkpB+aSJ/BMqenmdsa0eQ+W1JRsP+qp6dDQdOX4P1+noxj0CS/BnX6NWHiPjBSD+4RE8jSp8x8pRg0GgQ4cnOGt+k4iNzCziu4P+9ZZEy4k5ZFQPYGirpaBkdnXYGRBZo5n+oixy17Uj3Ys4Hhu5EShD3R7MBiP/9fzu+CRg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82efabbf-7829-4194-3162-08d77ddc98d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 01:51:10.5858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O0EYmMAqdFAl6JidorgpABR8OT8mNxHYfjFE2ZbBYAE8ovvTk6Yx+Ar0zAgbmG6C8VWIdrydEpP8ikwevSHW2zOhM3x/0pe8Nc32a+1HjLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1221
Subject: hashequiv, pseudo, and GIDs
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
X-List-Received-Date: Wed, 11 Dec 2019 01:51:12 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

I'm encountering a failure like below when using hashequiv. What is happeni=
ng is recipe "A" is installing some files in do_install, and changing the g=
roup of those files. The group is defined by a different recipe ("B"). Ther=
e is no dependency between A and B, so when A:do_package runs, the group is=
 not present in A's pseudo database. OEOuthashBasic tries to lookup the own=
ing group name of the file, and a KeyError is raised.

A workaround is to add:
    DEPENDS +=3D "B"
to recipe A, so that the group ends up in A's pseudo database. This works, =
but seems really really hacky, since it's only necessary when hashequiv is =
active.

So why is the group name used in the hash, as opposed to the GID? (I also h=
ave the same question regarding user name vs UID). If the GID was used we w=
ouldn't have this issue.

Thanks,
Chris


______________
ERROR: A-1.0-r0 do_package: Error executing a python function in exec_pytho=
n_func() autogenerated:

The stack trace of python calls that resulted in this exception/failure was=
:
File: 'exec_python_func() autogenerated', lineno: 2, function: <module>
     0001:
 *** 0002:sstate_report_unihash(d)
     0003:
File: '/home/laplante/yocto/sources/poky/meta/classes/sstate.bbclass', line=
no: 802, function: sstate_report_unihash
     0798:    report_unihash =3D getattr(bb.parse.siggen, 'report_unihash',=
 None)
     0799:
     0800:    if report_unihash:
     0801:        ss =3D sstate_state_fromvars(d)
 *** 0802:        report_unihash(os.getcwd(), ss['task'], d)
     0803:}
     0804:
     0805:#
     0806:# Shell function to decompress and prepare a package for installa=
tion
File: '/home/laplante/yocto/sources/poky/bitbake/lib/bb/siggen.py', lineno:=
 485, function: report_unihash
     0481:
     0482:            if "." in self.method:
     0483:                (module, method) =3D self.method.rsplit('.', 1)
     0484:                locs['method'] =3D getattr(importlib.import_modul=
e(module), method)
 *** 0485:                outhash =3D bb.utils.better_eval('method(path, si=
gfile, task, d)', locs)
     0486:            else:
     0487:                outhash =3D bb.utils.better_eval(self.method + '(=
path, sigfile, task, d)', locs)
     0488:
     0489:            try:
File: '/home/laplante/yocto/sources/poky/bitbake/lib/bb/utils.py', lineno: =
421, function: better_eval
     0417:    if extraglobals:
     0418:        ctx =3D copy.copy(ctx)
     0419:        for g in extraglobals:
     0420:            ctx[g] =3D extraglobals[g]
 *** 0421:    return eval(source, ctx, locals)
     0422:
     0423:@contextmanager
     0424:def fileslocked(files):
     0425:    """Context manager for locking and unlocking file locks."""
File: '<string>', lineno: 1, function: <module>
  File "<string>", line 1, in <module>

File: '/home/laplante/yocto/sources/poky/meta/lib/oe/sstatesig.py', lineno:=
 553, function: OEOuthashBasic
     0549:            process(root)
     0550:            for f in files:
     0551:                if f =3D=3D 'fixmepath':
     0552:                    continue
 *** 0553:                process(os.path.join(root, f))
     0554:    finally:
     0555:        os.chdir(prev_dir)
     0556:
     0557:    return h.hexdigest()
File: '/home/laplante/yocto/sources/poky/meta/lib/oe/sstatesig.py', lineno:=
 516, function: process
     0512:                    add_perm(stat.S_IXOTH, 'x')
     0513:
     0514:                if include_owners:
     0515:                    update_hash(" %10s" % pwd.getpwuid(s.st_uid).=
pw_name)
 *** 0516:                    update_hash(" %10s" % grp.getgrgid(s.st_gid).=
gr_name)
     0517:
     0518:                update_hash(" ")
     0519:                if stat.S_ISBLK(s.st_mode) or stat.S_ISCHR(s.st_m=
ode):
     0520:                    update_hash("%9s" % ("%d.%d" % (os.major(s.st=
_rdev), os.minor(s.st_rdev))))
Exception: KeyError: 'getgrgid(): gid not found: 3004'
______________

