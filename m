Return-Path: <fabrice.coulon@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by mail.openembedded.org (Postfix) with ESMTP id 728AA6D3AB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2013 07:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 5A7D9384EE0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2013 09:57:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6HbdHzRyXDDT for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2013 09:57:29 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by ra.se.axis.com (Postfix) with ESMTP id 6662E384EEE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2013 09:57:28 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 43858807
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2013 09:57:28 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 386737F8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2013 09:57:28 +0200 (CEST)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by seth.se.axis.com (Postfix) with ESMTP id 369B23E06F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2013 09:57:28 +0200 (CEST)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
	([10.0.5.75]) with mapi; Fri, 25 Oct 2013 09:57:28 +0200
From: Fabrice Coulon <fabrice.coulon@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Python tasks and scope
Thread-Index: AQHO0VfZVC2zJY1ScE2iN2wlJSDbGw==
Message-ID: <A612847CFE53224C91B23E3A5B48BAC7A40D0F4023@xmail3.se.axis.com>
Accept-Language: en-US, sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 20 Dec 2013 09:50:02 +0000
Subject: Python tasks and scope
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
Date: Fri, 25 Oct 2013 07:57:34 -0000
X-Original-Date: Fri, 25 Oct 2013 09:57:28 +0200
X-List-Received-Date: Fri, 25 Oct 2013 07:57:34 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am quite new to BitBake but there is something which I really do not unde=
rstand as a Python programmer.
And I was hoping somebody could help me with this problem.

I have had to write a recipe for some proprietary package which tries to do=
 the following:

 python do_get_uid_gid() {
    # Read UID and GID from some file not shown here
    d.setVar('UID', '1')
    d.setVar('GID', '2')
    bb.warn("UID =3D %s" % d.getVar('UID'))
}

addtask get_uid_gid before do_compile after do_configure

python do_print_data() {
    for k in d:
        print "=3D"*20
        print "|%s| -> |%s|" % (k, str(d.getVar(k)))
}

addtask print_data before do_compile after do_get_uid_gid

do_compile_prepend() {
    bbwarn "do_compile_prepend: UID=3D$UID, GID=3D$GID"
    bbwarn "d.getVar =3D "${@d.getVar('UID')}
}

When I look at the output after running bitbake <my-recipe>

WARNING: UID =3D 1
...

BUT In the "tmp/work/.../temp/log.do_compile",
I can read following:

DEBUG: Executing shell function do_compile
WARNING: do_compile_prepend: UID=3D, GID=3D
WARNING: d.getVar =3D None

I was expecting UID to be 1 and not "None" or "" in do_compile too.

As a Python programmer, if I can set a variable in a data structure called =
'd' which is defined
outside of the scope of "do_get_uid_gid" why can't I retrieve the data late=
r on with a getVar()
from another python or shell method?

I think that this is quite counter intuitive.=20

I actually had to inspect the d struct in "do_print_data" to discover that =
UID was not among the keys.

/Fabrice

