Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Greylist: delayed 715 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 30 Apr 2019 11:32:54 UTC
Received: from mail.cvg.de (mail.cvg.de [193.158.56.148])
	by mail.openembedded.org (Postfix) with ESMTP id 224ED7D52B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Apr 2019 11:32:54 +0000 (UTC)
Received: from mail-mta-0.intern.sigma-chemnitz.de
	(mail-mta-0.intern.sigma-chemnitz.de [192.168.12.76])
	by mailout-1.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id
	x3UBKwMU010367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 30 Apr 2019 13:20:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1556623259;
	bh=U24svCFMwdUXgAIdUJLfCV7nv/eXipo2RdQrkrPmWek=; l=969;
	h=From:To:Subject:Date;
	b=CEQfWnOXfN77TBzzjJZhlFjOcxhCot1wZGjUTvGk3yBIMDvMlkejXammAkEVpU1X/
	n3CfigqXm7yTtNNDduPlVJk36CZrMYyguxUbovYZSmoOWKJfQpPn2UsA/suDpHNhKw
	Dhy+BpATNnQLxTB1eRkc/3ENz3iAW29+XyNsV02Q=
Received: from reddoxx.intern.sigma-chemnitz.de
	(reddoxx.intern.sigma-chemnitz.de [192.168.0.193])
	by mail-mta-0.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id
	x3UBKqIi011519; Tue, 30 Apr 2019 13:20:52 +0200
Received: from mail-msa-0.intern.sigma-chemnitz.de ( [192.168.12.77]) by
	reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 4799D9D9320;
	Tue, 30 Apr 2019 13:20:51 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-0.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id
	x3UBKo5N011516
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO); Tue, 30 Apr 2019 13:20:51 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.92) (envelope-from <ensc@sigma-chemnitz.de>)
	id 1hLQoc-00Cr2I-Oi; Tue, 30 Apr 2019 13:20:50 +0200
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 30 Apr 2019 13:20:50 +0200
Message-ID: <lyftpzu4bx.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: $PWD in terminal.bbclass
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
X-List-Received-Date: Tue, 30 Apr 2019 11:32:55 -0000
Content-Type: text/plain

Hi,

terminal.bbclass exports the original environment before running the
terminal command.  This environment includes the original $PWD too so
that the generated script (run.do_terminal) looks like

| #!/usr/bin/env /bin/bash
| ...
| export PWD="/srv/projects/.../build"   << the directory with conf/local.conf e.g.
| ...
| do_terminal() {
| exec /bin/bash -c ...
| }


Assigning PWD works like 'cd' and changes the actual path so that
do_terminal() will be executed from the directory where bitbake has
been started from.  But usually, the [dirs] directory (e.g. '${B}') is
expected.

Is this really intented?  Here, this breaks kernel's '-c menuconfig' (at
least).

A trivial fix would be something like

|    envdata.delVar("PS1")
|+   envdata.delVar("PWD")

in terminal.bbclass.  But is there any reason to have PWD in ${BB_ORIGENV}
at all?  imo, there is no reason to keep this variable and it should be
removed in bitbake already.


Enrico

