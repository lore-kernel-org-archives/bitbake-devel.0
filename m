Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id C913660796
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Mar 2017 04:14:48 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v2G4EkVh027609
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Mar 2017 21:14:49 -0700
Received: from soho-mhatle-m.local (172.25.36.230) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Wed, 15 Mar 2017 21:14:45 -0700
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <2c5e1707-851f-5d82-15e8-a4c39bb8af89@windriver.com>
Date: Wed, 15 Mar 2017 23:14:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
	Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
Subject: _remove operator -- taskhash issue
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
X-List-Received-Date: Thu, 16 Mar 2017 04:14:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

I noticed something today on morty.  (So this might be fixed in master.)

I've got a variable that is defined as (-e output):

# $PACKAGECONFIG [20 operations]
#   _append[pn-qemu-native]
/home/mhatle/git/lpd/wr9-Base/build-test/conf/local.conf:384
#     " sdl"
#   _append[pn-nativesdk-qemu]
/home/mhatle/git/lpd/wr9-Base/build-test/conf/local.conf:385
#     " sdl"
#   set
/home/mhatle/git/lpd/wr9-Base/layers/oe-core/meta/conf/documentation.conf:317
#     [doc] "This variable provides a means of enabling or disabling features of
a recipe on a per-recipe basis."
#   set
/home/mhatle/git/lpd/wr9-Base/layers/oe-core/meta/recipes-graphics/mesa/mesa.inc:30
#     [_defaultval] "gbm egl gles dri ${MESA_CRYPTO}
${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '',
d)}           ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'wayland', '',
d)}           "
# pre-expansion value:
#   "gbm egl gles dri ${MESA_CRYPTO}
${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}           ${
@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'wayland', '', d)}           "
PACKAGECONFIG="gbm egl gles dri openssl                 x11
       "

(note lots of white space above).

If I add:

PACKAGECONFIG_remove_override = "foobar"

where the override is _NOT_ selected I now get, same as above --except-- for the
following:

#   _remove[override] /home/mhatle/git/lpd/wr9-Base/build-test/conf/local.conf:1
#     "foobar"
# pre-expansion value:
#   "gbm egl gles dri ${MESA_CRYPTO} ${@bb.utils.contains('DISTRO_FEATURES',
'x11', 'x11', '', d)} ${@bb.utils.contains('DISTRO_FEATURES', 'wayland',
'wayland', '', d)}"
PACKAGECONFIG="gbm egl gles dri openssl x11"


Note, the white space is gone, even though the evaluated contents of the
variable is not affected.  The problem with this is that it's changing the task
hash for my recipe's .bbappend, even though the override is not triggered.

--Mark

