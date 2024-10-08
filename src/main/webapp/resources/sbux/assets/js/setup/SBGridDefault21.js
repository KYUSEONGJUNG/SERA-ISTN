/*
 * 컴포넌트 기본값 설정
 */
(function (){
	SBUxG.DEF.SET_SBGRID_2_1 = {

		attributeType : {
			0: 'string',
			1: 'bool' ,
			2: 'number' ,
			3: 'function',
			4: 'array',
			5: 'objarray'
		}, // 복합적인 경우는 공백(object 도 해당)

		//************************
		// string type 인 경우
		// 예) "20px" 이나 "20" 이나 제품 스펙에 따라 변환되어
		// 맞게 적용되니 상관없이 사용.
		//************************

		// attribute 속성, 주의사항 이름에 data- 는 bootstrap 에서 사용하기 때문에 사용금지함.
		attributes : [
                        {oldName: 'strJsonRef',					newName: 'strJsonRef',					def: undefined,	type: 'string' },
		              	{oldName: 'strHint', 					newName: 'strHint',						def: undefined,	type: 'string' },
		              	{oldName: 'strBackColorAlternate',		newName: 'strBackColorAlternate',		def: undefined,	type: 'string' },
		              	{oldName: 'strBackColorFrozen',			newName: 'strBackColorFrozen',			def: undefined,	type: 'string' },
		              	{oldName: 'strDataHeight',				newName: 'strDataHeight',				def: undefined,	type: 'string' },
		              	{oldName: 'bDisabled',					newName: 'bDisabled',					def: undefined,	type: 'bool' },
		              	{oldName: 'strExtendLastCol',			newName: 'strExtendLastCol',			def: undefined,	type: 'string' },
		              	{oldName: 'nFixedCols',					newName: 'nFixedCols',					def: undefined,	type: 'number' },
		              	{oldName: 'bEllipsis',					newName: 'bEllipsis',					def: undefined,	type: 'bool' },
		              	{oldName: 'strExplorerbar',				newName: 'strExplorerbar',				def: undefined,	type: 'string' },
		              	{oldName: 'nFrozenCols',				newName: 'nFrozenCols',					def: undefined,	type: 'number' },
		              	{oldName: 'strFocusColor',				newName: 'strFocusColor',				def: undefined,	type: 'string' },
		              	{oldName: 'strForeColorFrozen',			newName: 'strForeColorFrozen',			def: undefined,	type: 'string' },
		              	{oldName: 'nFrozenBottomRows',			newName: 'nFrozenBottomRows',			def: undefined,	type: 'number' },
		              	{oldName: 'strMergeCells',				newName: 'strMergeCells',				def: undefined,	type: 'string' },
		              	{oldName: 'nFrozenRows',				newName: 'nFrozenRows',					def: undefined,	type: 'number' },
		              	{oldName: 'strMergeCellsFixedCols',		newName: 'strMergeCellsFixedCols',		def: undefined,	type: 'string' },
		              	{oldName: 'strMergeCellsFixedRows',		newName: 'strMergeCellsFixedRows',		def: undefined,	type: 'string' },
		              	{oldName: 'strOverflow',				newName: 'strOverflow',					def: undefined,	type: 'string' },
		              	{oldName: 'strScroll',					newName: 'strScroll',					def: undefined,	type: 'string' },
		              	{oldName: 'strSelectFontColor',			newName: 'strSelectFontColor',			def: undefined,	type: 'string' },
		              	{oldName: 'strRowHeader',				newName: 'strRowHeader',				def: undefined,	type: 'string' },
		              	{oldName: 'strRowHeight',				newName: 'strRowHeight',				def: undefined,	type: 'string' },
		              	{oldName: 'strSelectFontColorStyle',	newName: 'strSelectFontColorStyle',		def: undefined,	type: 'string' },
		              	{oldName: 'strSelectMode',				newName: 'strSelectMode',				def: undefined,	type: 'string' },
		              	{oldName: 'strToolTip',					newName: 'strToolTip',					def: undefined,	type: 'string' },
		              	{oldName: 'strSubTotalPosition',		newName: 'strSubTotalPosition',			def: undefined,	type: 'string' },
		              	{oldName: 'strStyle',					newName: 'strStyle',					def: undefined,	type: '' },
		              	{oldName: 'strEmptyRecords',			newName: 'strEmptyRecords',				def: undefined,	type: 'string' },
		              	{oldName: 'strEmptyRecordsFontStyle',	newName: 'strEmptyRecordsFontStyle',	def: undefined,	type: '' },
		              	{oldName: 'strDataReplace',				newName: 'strDataReplace',				def: undefined,	type: '' },
		              	{oldName: 'bIsDataReplaceValueChanged',	newName: 'bIsDataReplaceValueChanged',	def: undefined,	type: 'bool' },
		              	{oldName: 'bAllowCopy',					newName: 'bAllowCopy',					def: undefined,	type: 'bool' },
		              	{oldName: 'bAllowPaste',				newName: 'bAllowPaste',					def: undefined,	type: 'bool' },
		              	{oldName: 'strBeforeElementId',			newName: 'strBeforeElementId',			def: undefined,	type: 'string' },
		              	{oldName: 'bCreateAll',					newName: 'bCreateAll',					def: undefined,	type: 'bool' },
		              	{oldName: 'strNextElementId',			newName: 'strNextElementId',			def: undefined,	type: 'string' },
		              	{oldName: 'arContextMenuList',			newName: 'arContextMenuList',			def: undefined,	type: 'function' },
		              	{oldName: 'bContextMenu',				newName: 'bContextMenu',				def: undefined,	type: 'bool' },
		              	{oldName: 'bDataSearching',				newName: 'bDataSearching',				def: undefined,	type: 'bool' },
		              	{oldName: 'bIsShowLoadingImage',		newName: 'bIsShowLoadingImage',			def: undefined,	type: 'bool' },
		              	{oldName: 'bUseMultiSorting',			newName: 'bUseMultiSorting',			def: undefined,	type: 'bool' },
		              	{oldName: 'bAutoResize',                newName: 'bAutoResize',			        def: undefined, type: 'bool' },
		              	{oldName: 'strLoadingImagePath',		newName: 'strLoadingImagePath',			def: undefined,	type: '' },
		              	{oldName: 'bOneClickEdit',				newName: 'bOneClickEdit',				def: undefined,	type: 'bool' },
		              	{oldName: 'bUseFrozenSelect',			newName: 'bUseFrozenSelect',			def: undefined,	type: 'bool' },
		              	{oldName: 'strCellFocusColor',			newName: 'strCellFocusColor',			def: undefined,	type: 'string' },
		              	{oldName: 'bIsSortFrozenRows',			newName: 'bIsSortFrozenRows',			def: undefined,	type: 'bool' },
		              	{oldName: 'strContextMenuCallBack',		newName: 'strContextMenuCallBack',		def: undefined,	type: '' },
		              	{oldName: 'strFocusBorderColor',		newName: 'strFocusBorderColor',			def: undefined,	type: 'string' },
		              	{oldName: 'bUseFocusBorder',			newName: 'bUseFocusBorder',				def: undefined,	type: 'bool' },
		              	{oldName: 'strMoveFocusColor',			newName: 'strMoveFocusColor',			def: undefined,	type: 'string' },
		              	{oldName: 'bSubtotal',					newName: 'bSubtotal',					def: undefined,	type: 'bool' },

		              	{oldName: 'strCaption',					newName: 'strCaption',					def: undefined,	type: 'string' },
		              	{oldName: 'strColWidth',				newName: 'strColWidth',					def: undefined,	type: 'string' },
		              	{oldName: 'strColSep',				    newName: 'strColSep',					def: undefined,	type: 'string' },
		              	{oldName: 'strRowSep',				    newName: 'strRowSep',					def: undefined,	type: 'string' },
		              	{oldName: 'nReanderingRows',		    newName: 'nReanderingRows',				def: undefined,	type: 'number' },
		              	{oldName: 'bIsSortFrozenBottomRows',	newName: 'bIsSortFrozenBottomRows',     def: undefined,	type: 'bool' },
		              	{oldName: 'bAllowSelection',			newName: 'bAllowSelection',			    def: undefined,	type: 'bool' },
		              	{oldName: 'bDragMode',				    newName: 'bDragMode',			        def: undefined,	type: 'bool' },
		              	{oldName: 'strWhiteSpace',	            newName: 'strWhiteSpace',		        def: undefined,	type: 'string' }

		              ],
		// id , text, width, type, ref, style 은 변경 불가 요소임으로 대상이 아닙니다.
	      columns :   [
		             	{oldName: 'strJsonNodeSet',				newName: 'strJsonNodeSet',				def: undefined,	type: 'string' },
		             	{oldName: 'strLabelRef',				newName: 'strLabelRef',					def: undefined,	type: 'string' },
		             	{oldName: 'strValueRef',				newName: 'strValueRef',					def: undefined,	type: 'string' },
		             	{oldName: 'editmode',					newName: 'editmode',					def: undefined,	type: 'string' },
		             	{oldName: 'imageWidth',					newName: 'imageWidth',					def: undefined,	type: 'string' },
		             	{oldName: 'imageHeight',				newName: 'imageHeight',					def: undefined,	type: 'string' },
	                    {oldName: 'itemcount',					newName: 'itemcount',					def: undefined,	type: 'number' },
		             	{oldName: 'renderer',					newName: 'renderer',					def: undefined,	type: 'function' },
		              	{oldName: 'fixedRenderer',				newName: 'fixedRenderer',				def: undefined,	type: 'function' },
		              	{oldName: 'afterRenderer',				newName: 'afterRenderer',				def: undefined,	type: 'function' },
		              	{oldName: 'calc',						newName: 'calc',						def: undefined,	type: '' },
		              	{oldName: 'validate',					newName: 'validate',					def: undefined,	type: '' },
		              	{oldName: 'bIsColHidden',				newName: 'bIsColHidden',				def: undefined,	type: 'bool' },
		              	{oldName: 'strCheckValue',				newName: 'strCheckValue',				def: undefined,	type: 'string' },
		              	{oldName: 'maxlength',					newName: 'maxlength',					def: undefined,	type: 'number' },
		              	{oldName: 'bDataMerge',					newName: 'bDataMerge',					def: undefined,	type: 'bool' },
		              	{oldName: 'imageClick',     			newName: 'imageClick',      			def: undefined, type: 'string' },
		              	{oldName: 'bIsComboFiltering', 			newName: 'bIsComboFiltering',			def: undefined,	type: 'bool' },
		              	{oldName: 'inputdir',       			newName: 'inputdir',        			def: undefined, type: 'string' }
		              ],

      		export_excel : [
                 { oldName : 'strFileName',						newName : 'strFileName',   				def  : undefined, type : 'string' },
                 { oldName : 'strAction', 						newName : 'strAction',					def  : undefined, type : 'string' },
                 { oldName : 'objTitleInfo', 					newName : 'objTitleInfo',				def  : undefined, type : 'objarray' },
                 { oldName : 'bIsMerge', 						newName : 'bIsMerge',					def  : undefined, type : 'bool' },
                 { oldName : 'bUseFormat', 						newName : 'bUseFormat',					def  : undefined, type : 'bool' },
                 { oldName : 'bUseCompress', 					newName : 'bUseCompress',				def  : undefined, type : 'bool' },
                 { oldName : 'bIsStyle',					 	newName : 'bIsStyle',					def  : undefined, type : 'bool' },
                 { oldName : 'bIncludeData', 					newName : 'bIncludeData',   			def  : undefined, type : 'bool' },
                 { oldName : 'bAutoResize', 					newName : 'bAutoResize',				def  : undefined, type : 'bool' },
                 { oldName : 'bUseSeq', 						newName : 'bUseSeq',   					def  : undefined, type : 'bool' },
                 { oldName : 'arrAutoResizeCols', 				newName : 'arrAutoResizeCols',			def  : undefined, type : 'array' },
                 { oldName : 'arrRemoveCols', 					newName : 'arrRemoveCols',  			def  : undefined, type : 'array' },
                 { oldName : 'arrSkipMergeCols', 				newName : 'arrSkipMergeCols',  			def  : undefined, type : 'array' },
                 { oldName : 'arrNumberTypeCols', 				newName : 'arrNumberTypeCols',  		def  : undefined, type : 'array' },
                 { oldName : 'bSaveComboLabel', 				newName : 'bSaveComboLabel',			def  : undefined, type : 'bool' },
                 { oldName : 'bIncludeSubtotal',				newName : 'bIncludeSubtotal',			def  : undefined, type : 'bool' },
                 { oldName : 'arrAdditionalParam', 				newName : 'arrAdditionalParam',			def  : undefined, type : 'objarray' }
      		],
      		//subtotal 에서의 ref , calc 에서의 ref 같은 이름으로 사용되고 있으므로 구분을 위해 속성을 나눔
			total : {
				base 	 : [
								{ oldName : 'ref-group-col',	newName : 'keyByRef',   				def  : undefined, type : 'array' },
								{ oldName : 'decimal-point', 	newName : 'digit',   					def  : undefined, type : 'number' },
								{ oldName : 'display-decimal-point', newName : 'isConvertInteger',   	def  : undefined, type : 'bool' },
								{ oldName : 'sort-program', 	newName : 'isProgramSort',   			def  : undefined, type : 'bool' },
								{ oldName : 'emptydata-replace',newName : 'emptyDataReplace',   		def  : undefined, type : 'string' },
								{ oldName : 'duplicate-key', 	newName : 'isDuplicationKey',   		def  : undefined, type : 'bool' }
							],
				subtotal : [

								{ oldName : 'ref', 				newName : 'level',   					def  : undefined, type : 'string' },
								{ oldName : 'title', 			newName : 'title',   					def  : undefined, type : 'string' },
								{ oldName : 'position', 		newName : 'position',   				def  : undefined, type : 'string' },
								{ oldName : 'style', 			newName : 'style',   					def  : undefined, type : 'string' }

				            ],
	            grandtotal : [

	                          	{ oldName : 'ref', 				newName : 'level',   					def  : undefined, type : 'string' },
	                          	{ oldName : 'title', 			newName : 'title',   					def  : undefined, type : 'string' },
	                          	{ oldName : 'position', 		newName : 'position',   				def  : undefined, type : 'string' }

			            ],
				calc   	 : [
								{ oldName : 'calcs', 			newName : 'valueByRef',   				def  : undefined, type : 'string' },
								{ oldName : 'type',				newName : 'fixedCalc',   				def  : undefined, type : 'string' },
								{ oldName : 'ref',				newName : 'ref',   						def  : undefined, type : 'string' },
								{ oldName : 'calc-to-mergedvalue', newName : 'isMergeCellOneData',   	def  : undefined, type : 'bool' }
							]
			}
	};
}());