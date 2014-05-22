Return-Path: <mahyarelc@gmail.com>
X-Greylist: delayed 1472 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 22 May 2014 16:55:34 UTC
Received: from mail-we0-f181.google.com (unknown [74.125.82.181])
	by mail.openembedded.org (Postfix) with ESMTP id E91F965EA8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 May 2014 16:55:33 +0000 (UTC)
Received: by mail-we0-f181.google.com with SMTP id w61so3643465wes.26
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 May 2014 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=AR9G08CWeqdIu57lEKTU5+cjjlqc6AdKDK255J/o9TM=;
	b=h1rnqnqwFbzZmrDTEethJQr7YJUedmEoKPn0t1HqLNqy7BnuhrAsvouzPPxBSm0+g5
	vHOqNXRY85CEViKxNAiEYkAHPpjk50xp64yepDjpUMpnrOTQ23uvtsFYzVUP3p7wrsh5
	+WtlTvqATz3dTs/XLhO+T1XoTb9ZaEGZc8hOrmemykcOM78KZVmmXbCHQ8OWP6ZiFrPp
	GfwnmbNs+tJ9GSiViXT9l8hR+GFPD30XkZ1Z1J29G78NSJaB0jOc2Et6vrFymkH21QCA
	fdKaNl5UP9FB0jQzN/lOqRc7uYXePTq37jnkz7oABbBl6SU//pCXuqQ2duZQuLXzjzGV
	wQnQ==
MIME-Version: 1.0
X-Received: by 10.180.228.6 with SMTP id se6mr17486616wic.52.1400776263520;
	Thu, 22 May 2014 09:31:03 -0700 (PDT)
Received: by 10.194.80.99 with HTTP; Thu, 22 May 2014 09:31:03 -0700 (PDT)
Date: Thu, 22 May 2014 09:31:03 -0700
Message-ID: <CAB5p4qNLCwAvpanApx6XJ0BJKHLViggiFLUsgyb96dQ4+mVgHw@mail.gmail.com>
From: Mahyar Yaghmaee <mahyarelc@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: meta-ruby recipe fails
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
X-List-Received-Date: Thu, 22 May 2014 16:55:41 -0000
Content-Type: multipart/alternative; boundary=001a1135e39898dc2104f9ffa302

--001a1135e39898dc2104f9ffa302
Content-Type: text/plain; charset=UTF-8

Hello,

When I build ruby recipe with Yocto (located at
meta-openembedded/meta-ruby/recipes-devtools/ruby/ruby_1.9.3-p429.bb) on
Master branch, I get the following error:

Generating RDoc documentation
uh-oh! RDoc had a problem:

Directory .ext/rdoc already exists, but it looks like it isn't an RDoc
directory.

Because RDoc doesn't want to risk destroying any of your existing files,
you'll need to specify a different output directory name (using the --op
<dir>
option)


run with --debug for full backtrace
make: *** [rdoc] Error 1
ERROR: oe_runmake failed
WARNING: exit code 1 from a shell command.


Any suggestion on how to solve the problem would be great.
Thanks

--001a1135e39898dc2104f9ffa302
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>When I build ruby recipe with Yo=
cto (located at meta-openembedded/meta-ruby/recipes-devtools/ruby/<a href=
=3D"http://ruby_1.9.3-p429.bb">ruby_1.9.3-p429.bb</a>) on Master branch, I =
get the following error:</div>
<div><br></div><div><div>Generating RDoc documentation</div><div>uh-oh! RDo=
c had a problem:</div><div><br></div><div>Directory .ext/rdoc already exist=
s, but it looks like it isn&#39;t an RDoc directory.</div><div><br></div>
<div>Because RDoc doesn&#39;t want to risk destroying any of your existing =
files,</div><div>you&#39;ll need to specify a different output directory na=
me (using the --op &lt;dir&gt;</div><div>option)</div><div><br></div><div>
<br></div><div>run with --debug for full backtrace</div><div>make: *** [rdo=
c] Error 1</div><div>ERROR: oe_runmake failed</div><div>WARNING: exit code =
1 from a shell command.</div></div><div><br></div><div><br></div><div>Any s=
uggestion on how to solve the problem would be great.</div>
<div>Thanks</div></div>

--001a1135e39898dc2104f9ffa302--
