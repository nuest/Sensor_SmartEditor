/**
 * Copyright (C) ${inceptionYear}-2014 52°North Initiative for Geospatial Open Source
 * Software GmbH
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published
 * by the Free Software Foundation.
 *
 * If the program is linked with libraries which are licensed under one of
 * the following licenses, the combination of the program with the linked
 * library is not considered a "derivative work" of the program:
 *
 *     - Apache License, version 2.0
 *     - Apache Software License, version 1.0
 *     - GNU Lesser General Public License, version 3
 *     - Mozilla Public License, versions 1.0, 1.1 and 2.0
 *     - Common Development and Distribution License (CDDL), version 1.0
 *
 * Therefore the distribution of the program linked with libraries licensed
 * under the aforementioned licenses, is permitted by the copyright holders
 * if the distribution is compliant with both the GNU General Public
 * License version 2 and the aforementioned licenses.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 */
package org.n52.smarteditor.service;

import java.util.Collection;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.w3c.dom.Document;

import static org.junit.Assert.assertThat;
import static org.junit.Assert.fail;
import de.conterra.smarteditor.beans.BaseBean;
import de.conterra.smarteditor.service.BackendManagerService;
import de.conterra.smarteditor.util.DOMUtil;
import static org.junit.matchers.JUnitMatchers.containsString;
import static org.hamcrest.Matchers.not;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:/sml-BackendManagerService-config.xml")
public class TestBackendManagerService {
	@Resource(name = "backendSetupService")
	BackendManagerService backendManagerService;

	@Before
	public void before() {
		backendManagerService
				.setMergeDocument(DOMUtil.createDocumentFromSystemID(
						"classpath:/test-sensor.xml", true));
	}

	/**
	 * Tests if all needed beans are used in mergeBackend. If that is true all
	 * values "test" have to be overwritten by the beans.
	 */
	@Test
	public void testMergeBackend() {

		String docString2 = DOMUtil.convertToString(
				backendManagerService.mergeBackend(), false);
		assertThat(docString2, not(containsString("test")));
		
		String docString1 = DOMUtil.convertToString(
				backendManagerService.getMergeDocument(), false);
		assertThat(docString1, containsString("test"));

	}

	@Test
	public void testRegexSML() {

		for (Map.Entry<String, BaseBean> lEntry : backendManagerService
				.getBackend().getStorage().entrySet()) {
			// check if bean should be merged
			if (backendManagerService.isBeanActive(lEntry.getKey())) {
				assertThat(lEntry.getKey(), containsString("sml"));
			}
		}
	}

	@Test
	public void testRegexNOSML() {
		backendManagerService.setMergeDocument(DOMUtil
				.createDocumentFromSystemID("classpath:/templates/dataset.xml",
						true));
		for (Map.Entry<String, BaseBean> lEntry : backendManagerService
				.getBackend().getStorage().entrySet()) {
			// check if bean should be merged
			if (backendManagerService.isBeanActive(lEntry.getKey())) {
				assertThat(lEntry.getKey(), not(containsString("sml")));
			}
		}
	}
}
