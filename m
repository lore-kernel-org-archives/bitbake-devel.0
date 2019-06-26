Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id AF3766007A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Jun 2019 08:35:09 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x5Q8ZAjC024173
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 26 Jun 2019 01:35:10 -0700 (PDT)
Received: from localhost.corp.ad.wrs.com (128.224.162.182) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.439.0; Wed, 26 Jun 2019 01:35:08 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <901a2f37-99f2-57c5-923e-35c0cf92a1f5@windriver.com>
Date: Wed, 26 Jun 2019 16:35:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: #!/usr/bin/env python in bitbake files
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
X-List-Received-Date: Wed, 26 Jun 2019 08:35:09 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit


Hi RP,

I think that bitbake supports python3 years ago, but some files still
use "#!/usr/bin/env python" as shebang:

lib/bb/monitordisk.py:#!/usr/bin/env python
lib/bb/runqueue.py:#!/usr/bin/env python
lib/bb/taskdata.py:#!/usr/bin/env python
lib/bb/main.py:#!/usr/bin/env python
lib/bb/cookerdata.py:#!/usr/bin/env python
lib/bb/parse/parse_py/__init__.py:#!/usr/bin/env python
lib/bb/parse/parse_py/ConfHandler.py:#!/usr/bin/env python
lib/bb/parse/parse_py/BBHandler.py:#!/usr/bin/env python
lib/bb/namedtuple_with_abc.py:#!/usr/bin/env python
lib/bb/cooker.py:#!/usr/bin/env python
lib/pyinotify.py:#!/usr/bin/env python

And also a lot of files in lib/toaster/tests/.

Should we update them, please? Or should these files support python2?

-- 
Thanks

Robert

