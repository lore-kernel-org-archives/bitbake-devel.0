Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 3E39874598
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 May 2019 13:44:54 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x41DitUR011922
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 1 May 2019 06:44:55 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.439.0;
	Wed, 1 May 2019 06:44:54 -0700
To: <bitbake-devel@lists.openembedded.org>
References: <20190501111859.5699-1-richard.purdie@linuxfoundation.org>
	<20190501111859.5699-4-richard.purdie@linuxfoundation.org>
From: Mark Hatle <mark.hatle@windriver.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.hatle@windriver.com; prefer-encrypt=mutual; keydata=
	mQENBFYKxFgBCACt/pzutBp6p/xVKTFJjHbM3KpQKCblyot/YP+bpTr51Hrc5xDXBQhoG7TC
	aIRvRIvbhEevEQK9y04gW3JK/5lobq5ORebolcsHlYBUvpNeIPjupLQwGvz/TPtrLRNGLqDC
	rvsM6OA2XbQ2bwzxWaSQS3ImE2O2iXOZn9HhThMGeDB4Nff3fgUvXOTDIrgWOn9K2DgLL7Yc
	zkUIlFdj+Nraksd/7BSk8oH6tjeBVhFqSFvKta9QxWgdr58oPaTYaW/xNqUjlLrbJuMw/MSe
	xzuYfdfDfm6J8kRjMOnwQ0n8svJElzqAk+d83ow38gpGQ+LkjGgnf8ZFJ4rUJFADroX3ABEB
	AAG0JU1hcmsgSGF0bGUgPG1hcmsuaGF0bGVAd2luZHJpdmVyLmNvbT6JATcEEwEIACEFAlYK
	xFgCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQfv796/r0vvlvZAf9Gs+eN320yhRW
	V/fZCsngKhmOK4v3HrTwFrkSmoD9QHQiE/5IPdNacHwIPwZx07tNBohB8xOeNqCPRYRBwGhA
	AnxKOPyd0nnm6ZhPzbA57v4x3IGRQr4QzvcBTASJq91l3Ew4lpAslyx5w1DPPqRD7G8ycDKg
	peKyDwmdkvCunVisSAQI3XIMq2y230biTO98tDPEezg+lg+yTsz9ZT33F5KNuWrpf8VL5fG/
	mt+kAv7wtsx/KTRbqhH3iFXF6eBSwMjAfTXFlkLfbM9riJGXrWEl9n2S2R3cDHNHug0lb8f4
	whK370KEO4OwRKIYW/VUBmzk5XZUE9DTlDSV8ycsrrkBDQRWCsRYAQgAwK3FuHCE+HW3YWdH
	PUjeSn5p//xJ57u8g2rng8zm9zNjmYgpPv5UxozaD9i2jf4mlQLHGGOezhHae8K4Nj70oVcv
	8AmwcrJa9i9WL1oy/9R3fHMWf/Ctt9VXTO0qlCuq6PDzaUfvsXR61aJIjTKNQTOjCLjY1vXm
	VSewUgARysmA8WrjTfwGBihMBxAX0+kIjx8nOlam0WvekMBXZ0AbS56oTLRxYao6DI3GeB/N
	oWPy/5DfuTKaSdM0Pf8al20x9RuNN5/HLMlyDH/k8bIa1xd9aAqW+Feiw5gC107V2E6ULyIy
	q6em2UrsmIRxrvpHqbNgQKqvTehJ+V/i4g/uOwARAQABiQEfBBgBCAAJBQJWCsRYAhsMAAoJ
	EH7+/ev69L755XAH/3ZcNhooqd9OBhFkvXm1iWZ8EoC7motWqVn2oEyxoonsg8AD9kFXiN+T
	dYp7dH99EZu9q4ptj56AXm4uHzOgywL/5/V2TY6twCGAjUGzDjAB5gzoi+JLIBlDiyOip0eL
	QswIhRk473xy3j8DA4oVamnSPWgyNJ+qsdt37YWDzoDFFvtDoRU7Eb+znfIMDKzlny0XU/8L
	cW1bNHJlpv/78GPdfP4tjysEd8MuA5jf5o5w4XqcwTqalffEJtQ/s3pbkstEi7qm5uPui5Kt
	gq6YYLSqcSNe0GWAF9/T+qwyo7burSTxUWCWtMmlXdAQLW9SynLhB3Jbch0nFAh0fCKi6yY=
Organization: Wind River Systems
Message-ID: <686686b7-76a7-92c8-b21f-4ddf76e24550@windriver.com>
Date: Wed, 1 May 2019 08:44:54 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501111859.5699-4-richard.purdie@linuxfoundation.org>
Subject: Re: [PATCH 4/6] bitbake: Drop duplicate license boilerplace text
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
X-List-Received-Date: Wed, 01 May 2019 13:44:54 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 5/1/19 6:18 AM, Richard Purdie wrote:
> With the introduction of SPDX-License-Identifier headers, we don't need a ton
> of header boilerplate in every file. Simplify the files and rely on the top
> level for the full licence text.

I've actually been told the opposite by people.  That you still need the
boilerplate text for various jurisdiction, as the SPDX-License-Identifier may
not meet regional copyright/license requirements.

--Mark

> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  HEADER                                          | 13 -------------
>  bin/bitbake                                     | 12 ------------
>  bin/bitbake-diffsigs                            | 12 ------------
>  bin/bitbake-hashserv                            | 13 +------------
>  bin/bitbake-layers                              | 12 ------------
>  bin/bitbake-selftest                            | 12 ------------
>  bin/bitdoc                                      | 12 ------------
>  bin/toaster                                     | 12 ------------
>  bin/toaster-eventreplay                         | 12 ------------
>  lib/bb/COW.py                                   | 13 -------------
>  lib/bb/__init__.py                              | 12 ------------
>  lib/bb/build.py                                 | 13 -------------
>  lib/bb/cache.py                                 | 12 ------------
>  lib/bb/cache_extra.py                           | 12 ------------
>  lib/bb/checksum.py                              | 12 ------------
>  lib/bb/command.py                               | 12 ------------
>  lib/bb/cooker.py                                | 13 -------------
>  lib/bb/cookerdata.py                            | 12 ------------
>  lib/bb/data.py                                  | 13 -------------
>  lib/bb/data_smart.py                            | 12 ------------
>  lib/bb/event.py                                 | 12 ------------
>  lib/bb/fetch2/__init__.py                       | 13 -------------
>  lib/bb/fetch2/bzr.py                            | 12 ------------
>  lib/bb/fetch2/clearcase.py                      | 13 -------------
>  lib/bb/fetch2/cvs.py                            | 15 +--------------
>  lib/bb/fetch2/git.py                            | 12 ------------
>  lib/bb/fetch2/gitannex.py                       | 12 ------------
>  lib/bb/fetch2/gitsm.py                          | 12 ------------
>  lib/bb/fetch2/hg.py                             | 14 +-------------
>  lib/bb/fetch2/local.py                          | 14 +-------------
>  lib/bb/fetch2/perforce.py                       | 13 -------------
>  lib/bb/fetch2/repo.py                           | 14 +-------------
>  lib/bb/fetch2/s3.py                             | 13 -------------
>  lib/bb/fetch2/sftp.py                           | 13 -------------
>  lib/bb/fetch2/ssh.py                            | 12 ------------
>  lib/bb/fetch2/svn.py                            | 13 -------------
>  lib/bb/fetch2/wget.py                           | 13 -------------
>  lib/bb/main.py                                  | 12 ------------
>  lib/bb/methodpool.py                            | 12 ------------
>  lib/bb/monitordisk.py                           | 12 ------------
>  lib/bb/msg.py                                   | 12 ------------
>  lib/bb/parse/__init__.py                        | 14 +-------------
>  lib/bb/parse/ast.py                             | 13 -------------
>  lib/bb/parse/parse_py/BBHandler.py              | 13 -------------
>  lib/bb/parse/parse_py/ConfHandler.py            | 12 ------------
>  lib/bb/parse/parse_py/__init__.py               | 14 +-------------
>  lib/bb/persist_data.py                          | 12 ------------
>  lib/bb/progress.py                              | 12 ------------
>  lib/bb/providers.py                             | 12 ------------
>  lib/bb/remotedata.py                            | 12 ------------
>  lib/bb/runqueue.py                              | 12 ------------
>  lib/bb/server/__init__.py                       | 14 --------------
>  lib/bb/server/process.py                        | 12 ------------
>  lib/bb/server/xmlrpcclient.py                   | 12 ------------
>  lib/bb/server/xmlrpcserver.py                   | 12 ------------
>  lib/bb/taskdata.py                              | 12 ------------
>  lib/bb/tests/codeparser.py                      | 13 -------------
>  lib/bb/tests/cooker.py                          | 13 -------------
>  lib/bb/tests/cow.py                             | 13 -------------
>  lib/bb/tests/data.py                            | 13 -------------
>  lib/bb/tests/event.py                           | 13 -------------
>  lib/bb/tests/fetch.py                           | 13 -------------
>  lib/bb/tests/parse.py                           | 13 -------------
>  lib/bb/tests/persist_data.py                    | 13 -------------
>  lib/bb/tests/utils.py                           | 13 -------------
>  lib/bb/tinfoil.py                               | 12 ------------
>  lib/bb/ui/__init__.py                           | 12 ------------
>  lib/bb/ui/buildinfohelper.py                    | 12 ------------
>  lib/bb/ui/knotty.py                             | 12 ------------
>  lib/bb/ui/ncurses.py                            | 12 ------------
>  lib/bb/ui/taskexp.py                            | 12 ------------
>  lib/bb/ui/toasterui.py                          | 12 ------------
>  lib/bb/ui/uievent.py                            | 13 -------------
>  lib/bb/ui/uihelper.py                           | 12 ------------
>  lib/bb/utils.py                                 | 12 ------------
>  lib/hashserv/__init__.py                        | 12 ------------
>  lib/hashserv/tests.py                           | 12 ------------
>  lib/layerindexlib/__init__.py                   | 12 ------------
>  lib/layerindexlib/cooker.py                     | 12 ------------
>  lib/layerindexlib/plugin.py                     | 13 -------------
>  lib/layerindexlib/restapi.py                    | 12 ------------
>  lib/layerindexlib/tests/common.py               | 12 ------------
>  lib/layerindexlib/tests/cooker.py               | 12 ------------
>  lib/layerindexlib/tests/layerindexobj.py        | 12 ------------
>  lib/layerindexlib/tests/restapi.py              | 12 ------------
>  lib/pyinotify.py                                | 17 -----------------
>  lib/toaster/bldcollector/urls.py                | 13 -------------
>  lib/toaster/bldcollector/views.py               | 12 ------------
>  lib/toaster/bldcontrol/bbcontroller.py          | 13 -------------
>  lib/toaster/bldcontrol/localhostbecontroller.py | 13 -------------
>  .../orm/management/commands/lsupdates.py        | 12 ------------
>  lib/toaster/orm/models.py                       | 12 ------------
>  lib/toaster/tests/browser/selenium_helpers.py   | 13 -------------
>  .../tests/browser/selenium_helpers_base.py      | 13 -------------
>  .../tests/browser/test_all_builds_page.py       | 12 ------------
>  .../tests/browser/test_all_projects_page.py     | 12 ------------
>  .../tests/browser/test_builddashboard_page.py   | 12 ------------
>  .../test_builddashboard_page_artifacts.py       | 12 ------------
>  .../browser/test_builddashboard_page_recipes.py | 12 ------------
>  .../browser/test_builddashboard_page_tasks.py   | 12 ------------
>  lib/toaster/tests/browser/test_js_unit_tests.py | 12 ------------
>  lib/toaster/tests/browser/test_landing_page.py  | 12 ------------
>  .../tests/browser/test_layerdetails_page.py     | 12 ------------
>  .../browser/test_most_recent_builds_states.py   | 12 ------------
>  .../tests/browser/test_new_custom_image_page.py | 12 ------------
>  .../tests/browser/test_new_project_page.py      | 12 ------------
>  .../tests/browser/test_project_builds_page.py   | 12 ------------
>  .../tests/browser/test_project_config_page.py   | 12 ------------
>  lib/toaster/tests/browser/test_project_page.py  | 12 ------------
>  lib/toaster/tests/browser/test_sample.py        | 12 ------------
>  lib/toaster/tests/browser/test_task_page.py     | 12 ------------
>  .../tests/browser/test_toastertable_ui.py       | 12 ------------
>  lib/toaster/tests/builds/buildtest.py           | 12 ------------
>  lib/toaster/tests/builds/test_core_image_min.py | 13 -------------
>  lib/toaster/tests/commands/test_loaddata.py     | 12 ------------
>  lib/toaster/tests/commands/test_lsupdates.py    | 12 ------------
>  lib/toaster/tests/commands/test_runbuilds.py    | 12 ------------
>  lib/toaster/tests/eventreplay/__init__.py       | 12 ------------
>  .../tests/functional/functional_helpers.py      | 12 ------------
>  .../tests/functional/test_functional_basic.py   | 12 ------------
>  lib/toaster/tests/views/test_views.py           | 12 ------------
>  lib/toaster/toastergui/api.py                   | 13 -------------
>  lib/toaster/toastergui/buildtables.py           | 12 ------------
>  lib/toaster/toastergui/tablefilter.py           | 12 ------------
>  lib/toaster/toastergui/tables.py                | 12 ------------
>  .../toastergui/templatetags/projecttags.py      | 12 ------------
>  lib/toaster/toastergui/typeaheads.py            | 12 ------------
>  lib/toaster/toastergui/urls.py                  | 12 ------------
>  lib/toaster/toastergui/views.py                 | 13 -------------
>  lib/toaster/toastergui/widgets.py               | 12 ------------
>  .../management/commands/buildimport.py          | 12 ------------
>  .../management/commands/checksocket.py          | 12 ------------
>  lib/toaster/toastermain/settings.py             | 12 ------------
>  .../toastermain/settings_production_example.py  | 12 ------------
>  lib/toaster/toastermain/settings_test.py        | 12 ------------
>  lib/toaster/toastermain/urls.py                 | 12 ------------
>  136 files changed, 7 insertions(+), 1679 deletions(-)
> 

