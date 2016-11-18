Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com
	[209.85.214.50])
	by mail.openembedded.org (Postfix) with ESMTP id 1627F6FF9F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Nov 2016 15:22:11 +0000 (UTC)
Received: by mail-it0-f50.google.com with SMTP id c20so30752149itb.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Nov 2016 07:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:date:organization:mime-version
	:content-transfer-encoding;
	bh=j1zmNoHchbInsY0gmAHU8AzEsNVQvjgTeebxuoDtWIM=;
	b=X7o8Fr1ZUvgm7gH4yp8Lxh0Fb78WVlACxavJaI268q353SfIzVKOk6WfnkHo/NGH2b
	St/C+EiqiA977ONW8pvjOl5BGrNebRO/ccg/NX8HN6IIIO4zZPR2IZUnR588+FuVXUR6
	4vHodnQVdq2GShJ4J5Nj3UlcPbRd9TnEvAbH14aOSHMzUtunOmdTk/DFcavpp14Am8ZR
	IZbYnax/DwhHJQJ1kwTTUcX2Uyzc+5wX4S+uMnPETBxzLLSw9ZzKg3bSBXMieOlaLvAm
	2MDMUJoc94q25HmijVGcK8VRo5Rjb3nn462EoJkcBBgynINQi5+XcorGz5qSt7SWFEbm
	IEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:message-id:subject:from:to:date:organization
	:mime-version:content-transfer-encoding;
	bh=j1zmNoHchbInsY0gmAHU8AzEsNVQvjgTeebxuoDtWIM=;
	b=ecolT9tIHTFul+3T4ja1qo/VBF6FzGWngrbYe0GuQVy00T3QRXXsf2cPY1WyB2nb4c
	7M/1fiXBsh+ptyY7bVATLIAcsDD4nKU7cEQV5niXy5C4SCBYRQAIZdlXrOghk3ciqAh5
	6XSdH5PeOcQ+TjwlIGDBs9/Hv6uefrs2IoAoOgCWEDNzJxX4zhYXMoImsjBktGXsdJ/E
	E9u/Bga9pFqwAymeJ4A+y2p5SruMEGPBmnbGqEMyO8b/mp5Ro2dfs6W4FzGjVhLCNVvO
	uhERXNXGqch23OGJ+bYWnMarDV2+aJ0MpXS5SFNd7RjkAnZ15bQxPKmm7yUpZbmar6l1
	4Zsg==
X-Gm-Message-State: AKaTC03fQJoFrsGsYINIk3FO0DjTySkj2jLFfw6VLNB9UB7Y/4vd/DCjJrWK3n5opkUpoG+L
X-Received: by 10.107.159.68 with SMTP id i65mr173094ioe.153.1479482531946;
	Fri, 18 Nov 2016 07:22:11 -0800 (PST)
Received: from pohly-mobl1 (p5DE8EE38.dip0.t-ipconnect.de. [93.232.238.56])
	by smtp.gmail.com with ESMTPSA id l73sm884410ioe.37.2016.11.18.07.22.10
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 18 Nov 2016 07:22:11 -0800 (PST)
Message-ID: <1479482529.27625.76.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake <bitbake-devel@lists.openembedded.org>
Date: Fri, 18 Nov 2016 16:22:09 +0100
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Subject: shell parser: deep nesting
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
X-List-Received-Date: Fri, 18 Nov 2016 15:22:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello!

I ran into a bug
(https://bugzilla.yoctoproject.org/show_bug.cgi?id=10668) where parsing
a shell fragment like "echo hello & wait $!" triggers this error:

Traceback (most recent call last):
  File "/work/poky/bitbake/lib/bb/codeparser.py", line 400, in ShellParser.process_tokens(tokens=[('if_clause', <bb.pysh.pyshyacc.IfCond object at 0x7fb480963390>)]):
                 if more_tokens:
    >                self.process_tokens(more_tokens)
     
  File "/work/poky/bitbake/lib/bb/codeparser.py", line 400, in ShellParser.process_tokens(tokens=<itertools.chain object at 0x7fb480949278>):
                 if more_tokens:
    >                self.process_tokens(more_tokens)
     
  File "/work/poky/bitbake/lib/bb/codeparser.py", line 400, in ShellParser.process_tokens(tokens=[('while_clause', <bb.pysh.pyshyacc.WhileLoop object at 0x7fb480949518>)]):
                 if more_tokens:
    >                self.process_tokens(more_tokens)
     
  File "/work/poky/bitbake/lib/bb/codeparser.py", line 400, in ShellParser.process_tokens(tokens=<itertools.chain object at 0x7fb480446668>):
                 if more_tokens:
    >                self.process_tokens(more_tokens)
     
  File "/work/poky/bitbake/lib/bb/codeparser.py", line 393, in ShellParser.process_tokens(tokens=[[('pipeline', <bb.pysh.pyshyacc.Pipeline object at 0x7fb480949c88>)]]):
             for token in tokens:
    >            name, value = token
                 try:
ValueError: need more than 1 value to unpack

After thinking about this a bit more I *think* I understand the problem
(expecting a certain level of nesting while the parser may also hand out
tokens with deeper nesting in the pipeline case) and I'll send a patch
fixing the issue for me.

But I'm not entirely sure whether that's really addressing the root
cause of the problem - perhaps such deep nesting shouldn't occur?

So I hope that someone familiar with this code can have a look at the
problem and the proposed solution.

Also, does it have performance implications that
ShellParser.process_tokens() defines the same helper functions
repeatedly? They don't depend on the current invocation context and thus
could also be defined as private helper functions in ShellParser.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




